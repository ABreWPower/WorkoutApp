<script setup>
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
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

// Class that pulls data from GraphQL and store it so Vue can render it
const workoutController = {
  workoutLogId: null,       // int
  workoutData: null,        // object
  workoutQueue: [],         // array
  activeExercise: null,     // int
  timer: 0,                 // int
  timerIntervalID: null,    // int

  // Load workout/exercise data from apollo server
  loadWorkout: function() {
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
        }
      }
    `
    client.query({
      query: getActiveWorkoutData,
      variables: { workoutlogsId: this.workoutLogId },
      fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
    })
    .then(result => {
      console.log("loadWorkout result", result)
      workoutController.workoutData = result.data.workoutlogs[0]
      // TODO add a 5 second transition into the new workout???
      workoutController.workoutData.exerciselogs.forEach(exercise => {
        if(exercise.sets == null || exercise.sets == 0) exercise.sets = 1   // Assume the user meant to have at least 1 set
        for(let i = 0; i < exercise.sets; i++) {
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
      workoutController.activeExercise = 0
      workoutController.copyActiveRecord()

      console.log("id", parseInt(activeRecord.value.id))
      // Start the first exerciselog
      client.mutate({
        mutation: startExerciseLog,
        variables: { startExerciseLogId: parseInt(activeRecord.value.id)}
      }).then(result => {
        // console.log("startExerciseLog result", result)
        // TODO validate this query didn't fail
      })

      // Start timer
      workoutController.timerIntervalID = setInterval(function() {workoutController.timer++}, 1000)
      console.log("timer", workoutController.timer)
    })
  },

  // Current exercise over to the active record for use by Vue
  copyActiveRecord: function() {
    activeRecord.value = workoutController.workoutQueue[workoutController.activeExercise]
  },

  // Move to next exercise
  moveNext: function() {
    console.log("timer", workoutController.timer)
    
    let currentExerciseID = parseInt(workoutController.workoutQueue[workoutController.activeExercise].id)
    console.log("currentExerciseID", currentExerciseID)

    // Check if last exercise and call endExercise & endWorkout mutator
    console.log("activeExercise & workoutQueue.length", this.activeExercise, this.workoutQueue.length)
    if(this.activeExercise == this.workoutQueue.length - 1) {
      // Finish the workout
      // TODO need to change the button text to "Finish" instead of "continue"
      console.log("end workout")
      client.mutate({
        mutation: endExerciseLog,
        variables: { endExerciseLogId: currentExerciseID, span: parseInt(workoutController.timer) }
      }).then(result => {
        // console.log("endExerciseLog result", result)
        // TODO validate this query didn't fail
      })

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
      router.push({ name: "Workouts"})
    }
    else {
      // Move to the next exercise          
      this.activeExercise++
      this.copyActiveRecord()
      
      // If exerciseid changed; call end/start exercise mutator & reset timer
      if(currentExerciseID != activeRecord.value.id) {
        console.log("end exercise")
        client.mutate({
          mutation: endExerciseLog,
          variables: { endExerciseLogId: currentExerciseID, span: parseInt(workoutController.timer) }
        }).then(result => {
          // console.log("endExerciseLog result", result)
          // TODO validate this query didn't fail
        })

        // Start the next exerciselog
        client.mutate({
          mutation: startExerciseLog,
          variables: { startExerciseLogId: parseInt(activeRecord.value.id)}
        }).then(result => {
          // console.log("startExerciseLog result", result)
          // TODO validate this query didn't fail
        })

        workoutController.timer = 0
        console.log("workoutController.timer", workoutController.timer)
      }
    }
    
  }
}

// Start the workout controller and exercises
workoutController.workoutLogId = parseInt(routeObj.params.workoutlogid)
workoutController.loadWorkout()

</script>

<template>
  <h1 style="font-size: 50px">{{ activeRecord.exerciseName }}</h1>
  <p style="font-size: 30px">Equipment: {{ activeRecord.exerciseEquipment }}</p>

  <!-- <pre>
    activeRecord.Reps: {{ activeRecord.reps }}
    activeRecord.Duration: {{ activeRecord.duration }}
    activeRecord.Weight: {{ activeRecord.weight }}
    activeRecord.ExerciseName: {{ activeRecord.exerciseName }}
    activeRecord.ExercisePicture: {{ activeRecord.exercisePicture }}
    activeRecord.ExerciseVideo: {{ activeRecord.exerciseVideo }}
    activeRecord.ExerciseInstructions: {{ activeRecord.exerciseInstructions }}
  </pre> -->

  <!-- TODO Split the rest of the space into 3 equal parts -->
  <div class="row">
    <!-- Clock countdown/reps/duration -->
    <h1 class="display-1">{{ activeRecord.reps ? activeRecord.reps + ' Reps' : activeRecord.duration + ' Seconds' }} {{ activeRecord.weight ? activeRecord.weight + ' lbs' : '' }}</h1>
  </div>
  <div class="row">
    <!-- Video/instructions -->
    <h1 class="display-4">Instructions: {{ activeRecord.exerciseInstructions }}</h1>
  </div>
  <div class="row">
    <div class="col1">
      <button type="button" class="btn btn-success btn-lg" @click="workoutController.moveNext()">Continue</button>
    </div>
  </div>

  <nav class="navbar fixed-bottom navbar-dark bg-primary" style="color: white; padding-left: 20px; padding-right 20px;">
    <div class="container-fluid">
      <!-- <form class="container-fluid justify-content-start"> -->
      <button class="btn btn-outline-danger" type="button" style="color: white">Pause</button>
      <!-- </form> -->
      <span class="navbar-text"> Total Time: TODO Total Time</span>
    </div>
  </nav>
</template>

<style scoped>
div.card-view:last-child div.card {
  margin-bottom: 0 !important;
}

/* top nav -56px
   bottom nav -56px */
</style>
