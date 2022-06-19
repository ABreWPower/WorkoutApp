<script setup>
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("workout edit router params", routeObj.params)


// Objects for Vue to render
const activeRecord = ref({})

/*
load data from the server
copy active record to activeVariables
supply handler/function to move next
*/

const workoutController = {
  workoutLogId: null,       //int
  workoutData: null,        //object
  workoutQueue: [],       //array
  activeExercise: null,     //int

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
      workoutController.workoutData.exerciselogs.forEach(exercise => {
        if(exercise.sets == null || exercise.sets == 0) exercise.sets = 1   //if no sets, set to 1
        for(let i = 0; i < exercise.sets; i++) {
          //TODO: include exercise ID in exerciuse and rest
          workoutController.workoutQueue.push({
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
            reps: null,
            duration: exercise.rest ? exercise.rest : 5,
            weight: null,
            exerciseName: "Rest",
            exercisePicture: "rest.jpg",
            exerciseVideo: null,
            exerciseInstructions: "Rest",
            exerciseEquipment: "The floor"
          })
        }
      })
      workoutController.activeExercise = 0
      workoutController.copyActiveRecord()
      //TODO: Call start exercise mutator
      //TODO: Start timer
    })
  },
  // copy "active" record to activeVariables
  copyActiveRecord: function() {
    activeRecord.value = workoutController.workoutQueue[workoutController.activeExercise]
  },
  // move to next exercise
  moveNext: function() {
    //TODO: check if last exercise and call endExercise & endWorkout mutator
    this.activeExercise++
    this.copyActiveRecord()
    //if exerciseid changed; call end/start exercise mutator & reset timer
    //setInterval(function() {console.log("Interval")}, 2000)
    //clearInterval()
  }
}


workoutController.workoutLogId = parseInt(routeObj.params.workoutlogid)
workoutController.loadWorkout()


</script>

<template>
  <h1>{{ activeRecord.exerciseName }}</h1>
  <p>Equipment: {{ activeRecord.exerciseEquipment }}</p>

  <pre>
    activeRecord.Reps: {{ activeRecord.reps }}
    activeRecord.Duration: {{ activeRecord.duration }}
    activeRecord.Weight: {{ activeRecord.weight }}
    activeRecord.ExerciseName: {{ activeRecord.exerciseName }}
    activeRecord.ExercisePicture: {{ activeRecord.exercisePicture }}
    activeRecord.ExerciseVideo: {{ activeRecord.exerciseVideo }}
    activeRecord.ExerciseInstructions: {{ activeRecord.exerciseInstructions }}
  </pre>

  <!-- TODO Split the rest of the space into 3 equal parts -->
  <div class="row">
    <!-- TODO Clock countdown/reps/duration -->
  </div>
  <div class="row">
    <!-- TODO Video/instructions -->
  </div>
  <div class="row">
    <div class="col1">
      <!-- TODO Rep stuff -->
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
