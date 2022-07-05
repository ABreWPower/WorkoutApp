<script setup>
import { client, forceNetworkJQL } from "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute, onBeforeRouteLeave } from 'vue-router'
import { ref, watch } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("workout edit router params", routeObj.params)

// Start exercise mutator
const startExerciseLog = gql`
  mutation StartExerciseLog($startExerciseLogId: Int!) {
    startExerciseLog(id: $startExerciseLogId) {
      id
    }
  }
`

// End exercise mutator
const endExerciseLog = gql`
  mutation EndExerciseLog($endExerciseLogId: Int!, $span: Int) {
    endExerciseLog(id: $endExerciseLogId, span: $span) {
      id
    }
  }
`

// End workout mutator
const endWorkoutLog = gql`
  mutation EndWorkoutLog($endWorkoutLogId: Int!) {
    endWorkoutLog(id: $endWorkoutLogId) {
      id
    }
  }
`

// Objects for Vue to render
const activeRecord = ref({})
const nextExerciseRecord = ref({})
const activeCountDownTimer = ref()
const totalDurationCounter = ref(0)

// Speech reconition variables
let recognition = null
let continueRecognition = true

// Functions for Workout Controller
// Function for the intervals to call and change values
var intervalFunction = function () {
  // console.log("timer, countDownTimer", workoutController.timer, activeCountDownTimer)
  workoutController.timer++           // Increment the workout timer
  activeCountDownTimer.value--  // Decrement the display timer for duration exercieses and rest
  totalDurationCounter.value++
  //console.log("timer, countDownTimer", workoutController.timer, activeCountDownTimer.value)
}

// Starting an exercise function
function startExerciseLogFunc() {
  if (activeRecord.value.id != null) {
    client.mutate({
      mutation: startExerciseLog,
      variables: { startExerciseLogId: parseInt(activeRecord.value.id) }
    }).then(result => {
      // console.log("startExerciseLog result", result)
      // TODO validate this query didn't fail
    })
  }
}

// End an exercise function
function endExerciseLogFunc(currentExerciseID) {
  if (currentExerciseID != null && !isNaN(currentExerciseID)) {
    client.mutate({
      mutation: endExerciseLog,
      variables: { endExerciseLogId: currentExerciseID, span: parseInt(workoutController.timer) }
    }).then(result => {
      // console.log("endExerciseLog result", result)
      // TODO validate this query didn't fail
    })
  }
}

// Class that pulls data from GraphQL and store it so Vue can render it
const workoutController = {
  workoutLogId: null,       // int
  workoutData: null,        // object
  workoutQueue: [],         // array
  activeExercise: null,     // int
  timer: 0,                 // int
  timerIntervalID: null,    // int
  circuit_rounds: 1,        // int


  // Load workout/exercise data from apollo server
  loadWorkout: function () {
    const getActiveWorkoutData = gql`
      query Query($workoutlogsId: ID) {
        workoutlogs(id: $workoutlogsId) {
          id
          exerciselogs {
            id
            sets
            reps
            duration
            rest
            weight
            exercise {
              id
              name
              picture
              video
              instructions
              equipment {
                name
                icon
              }
            }
          }
          workout {
            circuit_rounds
          }
        }
      }
    `
    client.query({
      query: getActiveWorkoutData,
      variables: { workoutlogsId: this.workoutLogId },
      fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
    })
      .then(result => {
        // console.log("loadWorkout result", result)
        workoutController.workoutData = result.data.workoutlogs[0]
        // All users to prep before starting the working
        workoutController.workoutQueue.push({
          id: null,
          reps: null,
          duration: 5,
          weight: null,
          exerciseName: "Get Ready",
          exercisePicture: null,
          exerciseVideo: null,
          exerciseInstructions: "Get Ready",
          exerciseEquipment: ""
        })
        // Loop through and create the list of workouts to perform
        workoutController.circuit_rounds = workoutController.workoutData.workout.circuit_rounds
        for (let i = 0; i < workoutController.circuit_rounds; i++) {
          workoutController.workoutData.exerciselogs.forEach(exercise => {
            if (exercise.sets == null || exercise.sets == 0) exercise.sets = 1   // Assume the user meant to have at least 1 set
            for (let j = 0; j < exercise.sets; j++) {
              workoutController.workoutQueue.push({
                id: exercise.id,
                reps: exercise.reps,
                duration: exercise.duration,
                weight: exercise.weight,
                exerciseName: exercise.exercise.name,
                exercisePicture: exercise.exercise.picture,
                exerciseVideo: exercise.exercise.video,
                exerciseInstructions: exercise.exercise.instructions,
                exerciseEquipment: exercise.exercise.equipment.flatMap(element => [element.name]).join(", ")
              })
              workoutController.workoutQueue.push({
                id: exercise.id,
                reps: null,
                duration: exercise.rest ? exercise.rest : 5,
                weight: null,
                exerciseName: "Rest",
                exercisePicture: "rest.jpg",
                exerciseVideo: null,
                exerciseInstructions: "Take a break, let your heart rate lower, drink water if needed, and get ready for the next set.",
                exerciseEquipment: "The floor"
              })
            }
          })
        }
        workoutController.activeExercise = 0
        workoutController.copyActiveRecord()

        // console.log("id", parseInt(activeRecord.value.id))
        // Start the first exerciselog
        startExerciseLogFunc()

        // Start timer
        workoutController.timerIntervalID = setInterval(intervalFunction, 1000)
        // console.log("timer", workoutController.timer)
      })
  },

  // Current exercise over to the active record for use by Vue
  copyActiveRecord: function () {
    activeRecord.value = workoutController.workoutQueue[workoutController.activeExercise]
    activeCountDownTimer.value = activeRecord.value.duration
    if (workoutController.activeExercise != workoutController.workoutQueue.length - 1) {
      nextExerciseRecord.value = workoutController.workoutQueue[workoutController.activeExercise + 1]
    }
    else {
      nextExerciseRecord.value = {
        id: null,
        reps: 0,
        duration: 0,
        weight: 0,
        exerciseName: "Finished",
        exercisePicture: "finished.jfif",
        exerciseVideo: null,
        exerciseInstructions: "You have completed this workout",
        exerciseEquipment: "The world"
      }
    }
    if (activeRecord.value.reps > 0) workoutController.startSpeechToText()
    else {
      continueRecognition = false
      if (recognition != null) {
        recognition.stop()
      }
    }
  },

  // Move to next exercise
  moveNext: function () {
    // console.log("timer", workoutController.timer)
    // console.log("activeCountDownTimer", activeCountDownTimer.value)

    let currentExerciseID = parseInt(workoutController.workoutQueue[workoutController.activeExercise].id)
    // console.log("currentExerciseID", currentExerciseID)

    // Check if last exercise and call endExercise & endWorkout mutator
    // console.log("activeExercise & workoutQueue.length", this.activeExercise, this.workoutQueue.length)
    if (this.activeExercise == this.workoutQueue.length - 1) {
      // Finish the workout
      // TODO need to change the button text to "Finish" instead of "continue"
      console.log("end workout")
      endExerciseLogFunc(currentExerciseID)

      client.mutate({
        mutation: endWorkoutLog,
        variables: { endWorkoutLogId: this.workoutLogId }
      }).then(result => {
        // console.log("endWorkoutLog result", result)
        // TODO validate this query didn't fail
      })

      // Clear the interval
      clearInterval(workoutController.timerIntervalID)

      // TODO go to another page (workout summary)
      router.push({ name: "Workouts" })
    }
    else {
      // Move to the next exercise          
      this.activeExercise++
      this.copyActiveRecord()

      // If exerciseid changed; call end/start exercise mutator & reset timer
      if (currentExerciseID != activeRecord.value.id) {
        // console.log("end exercise")
        endExerciseLogFunc(currentExerciseID)

        // Start the next exerciselog
        startExerciseLogFunc()

        workoutController.timer = 0
        // console.log("workoutController.timer", workoutController.timer)
      }
    }

  },
  startSpeechToText() {
    window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition
    recognition = new window.SpeechRecognition()
    recognition.lang = "en-US"
    recognition.interimResults = false
    recognition.continuous = true
    continueRecognition = true

    // event current voice reco word
    recognition.addEventListener("result", event => {
      var text = Array.from(event.results)
        .map(result => result[0])
        .map(result => result.transcript)
        .join("")
      console.log("result:", text)
      //check for phrases inside our result text
      let phrases = [
        "continue workout",
        "workout continue",
        "next exercise",
        "next workout",
        "i'm gonna die"
      ]
      if (phrases.find(phrases => text.search(phrases) != -1)) {
        recognition.stop()
        continueRecognition = false
        workoutController.moveNext()
      }
    })
    // end of transcription
    recognition.addEventListener("end", () => {
      recognition.stop()
      if (continueRecognition) recognition.start()
    })
    recognition.start()
  }
}

// Create watcher to move to the next workout when the value reaches 0
watch(activeCountDownTimer, (newValue, oldValue) => {
  //console.log("count down timer watcher:", newValue, oldValue);
  if (oldValue > 0 && newValue == 0) {
    workoutController.moveNext()
  }
});

// Start the workout controller and exercises
workoutController.workoutLogId = parseInt(routeObj.params.workoutlogid)
workoutController.loadWorkout()

function pauseContinueButtonClick() {
  let pauseContinue = document.getElementById("pauseContinueButton")

  if (workoutController.timerIntervalID == null) {
    workoutController.timerIntervalID = setInterval(intervalFunction, 1000)
    pauseContinue.style.backgroundColor = "transparent"
    pauseContinue.innerText = "Pause"
  }
  else {
    clearInterval(workoutController.timerIntervalID)
    workoutController.timerIntervalID = null
    pauseContinue.style.backgroundColor = "#ffc107"
    pauseContinue.innerText = "Continue"
  }
}

// Cleanup timer and speech recognition before moving to another page
onBeforeRouteLeave((to, from) => {
  clearInterval(workoutController.timerIntervalID)
  continueRecognition = false
  if (recognition != null) {
    recognition.stop()
  }
})

</script>

<template>
  <h1 style="font-size: 50px">{{ activeRecord.exerciseName }}</h1>
  <p style="font-size: 30px">Equipment: {{ activeRecord.exerciseEquipment }}</p>

  <!-- TODO Split the rest of the space into 3 equal parts -->
  <div class="row">
    <!-- Clock countdown/reps/duration -->
    <h1 class="display-1">{{ activeRecord.reps ? activeRecord.reps + ' Reps' : activeCountDownTimer + ' Seconds' }} {{ activeRecord.weight ? activeRecord.weight + ' lbs' : '' }}</h1>
  </div>
  <div class="row" v-bind="$attrs">
    <!-- Video/instructions -->
    <h1 v-if="activeRecord.exerciseName != 'Rest'" class="display-4">Instructions: {{ activeRecord.exerciseInstructions }}</h1>

    <div v-if="activeRecord.exerciseName == 'Rest' || activeRecord.exerciseName == 'Get Ready'" class="card mb-3 border-secondary" style="max-height: 12em; cursor: pointer" @click="cardClick">
      <div class="row g-0">
        <div class="col-4 align-self-center">
          <img :src="`/${nextExerciseRecord.exercisePicture}`" class="img-fluid rounded-start w-100" style="max-height: 8em; max-width: 180px" />
        </div>
        <div class="col-8">
          <div class="card-body">
            <h5 class="card-title">Next Exercise: {{ nextExerciseRecord.exerciseName }}</h5>
            <p class="card-text overflow-hidden" style="text-overflow: ellipsis; -webkit-line-clamp: 2; -webkit-box-orient: vertical; display: -webkit-box">Instructions: {{ nextExerciseRecord.exerciseInstructions }}</p>
            <p>Equipment: {{ nextExerciseRecord.exerciseEquipment }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row buttonBottom" style="width: 100vw; margin: auto">
    <div v-if="activeRecord.reps > 0" class="col-4">
      <button type="button" class="btn btn-success btn-lg" @click="workoutController.moveNext()">Continue</button>
    </div>
    <div class="col-4">
      <p>Exercise: {{ workoutController.activeExercise }} out of {{ workoutController.workoutQueue.length }}</p>
    </div>
  </div>

  <nav class="navbar fixed-bottom navbar-dark bg-primary" style="color: white; padding-left: 20px; padding-right 20px;">
    <div class="container-fluid">
      <!-- <form class="container-fluid justify-content-start"> -->
      <button id="pauseContinueButton" class="btn btn-outline-warning" type="button" style="color: white" @click="pauseContinueButtonClick()">Pause</button>
      <!-- </form> -->
      <span class="navbar-text"> Total Time: {{ Math.round(totalDurationCounter / 60) }} minutes</span>
    </div>
  </nav>
</template>

<style scoped>
div.card-view:last-child div.card {
  margin-bottom: 0 !important;
}

.buttonBottom {
  position: fixed;
  bottom: 100px;
}

/* top nav -56px
   bottom nav -56px */
</style>
