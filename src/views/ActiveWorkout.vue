<script setup>
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("workout edit router params", routeObj.params)


// Objects for Vue to render
const activeSets = ref()
const activeReps = ref()
const activeDuration = ref()
const activeRest = ref()
const activeWeight = ref()
const activeExerciseName = ref()
const activeExercisePicture = ref()
const activeExerciseVideo = ref()
const activeExerciseInstructions = ref()
const activeExerciseEquipment = ref()


/*
load data from the server
copy active record to activeVariables
supply handler/function to move next
*/

const workoutController = {
  workoutLogId: null,       //int
  workoutData: null,        //object
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
      workoutController.workoutData = result.data.workoutlogs[0]   //TODO: json parse/stringify??
      workoutController.activeExercise = 0
      workoutController.copyActiveRecord()
    })
  },
  // copy "active" record to activeVariables
  copyActiveRecord: function() {
    console.log("copyActiveRecord, activeExercise", this.activeExercise)
    console.log("copyActiveRecord, name: ", workoutController.workoutData.exerciselogs[this.activeExercise].exercise.name)
    activeSets.value = workoutController.workoutData.exerciselogs[this.activeExercise].sets
    activeReps.value = workoutController.workoutData.exerciselogs[this.activeExercise].reps
    activeDuration.value = workoutController.workoutData.exerciselogs[this.activeExercise].duration
    activeRest.value = workoutController.workoutData.exerciselogs[this.activeExercise].rest
    activeWeight.value = workoutController.workoutData.exerciselogs[this.activeExercise].weight
    activeExerciseName.value = workoutController.workoutData.exerciselogs[this.activeExercise].exercise.name
    activeExercisePicture.value = workoutController.workoutData.exerciselogs[this.activeExercise].exercise.picture
    activeExerciseVideo.value = workoutController.workoutData.exerciselogs[this.activeExercise].exercise.video
    activeExerciseInstructions.value = workoutController.workoutData.exerciselogs[this.activeExercise].exercise.instructions
    activeExerciseEquipment.value = workoutController.workoutData.exerciselogs[this.activeExercise].exercise.equipment.flatMap(element => [element.name]).join(", ")
  },
  // move to next exercise
  moveNext: function() {
    //TODO: check if last exercise
    this.activeExercise++
    this.copyActiveRecord()
  }
}


workoutController.workoutLogId = parseInt(routeObj.params.workoutlogid)
workoutController.loadWorkout()


</script>

<template>
  <h1>{{ activeExerciseName }}</h1>
  <p>Equipment: {{ activeExerciseEquipment }}</p>

  <pre>
    activeSets: {{ activeSets }}
    activeReps: {{ activeReps }}
    activeDuration: {{ activeDuration }}
    activeRest: {{ activeRest }}
    activeWeight: {{ activeWeight }}
    activeExerciseName: {{ activeExerciseName }}
    activeExercisePicture: {{ activeExercisePicture }}
    activeExerciseVideo: {{ activeExerciseVideo }}
    activeExerciseInstructions: {{ activeExerciseInstructions }}
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
