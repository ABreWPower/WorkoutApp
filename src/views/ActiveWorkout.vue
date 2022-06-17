<script setup>
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("workout edit router params", routeObj.params)

let getActiveWorkoutData = gql`
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

var somethingcool = null
var exerciseName = ref()

client.query({
  query: getActiveWorkoutData,
  variables: { workoutlogsId: parseInt(routeObj.params.workoutlogid)},
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("results", result)
  somethingcool = result.data.workoutlogs[0]
  exerciseName.value = somethingcool.exerciselogs[0].exercise.name
})



</script>

<template>
  <h1>Here {{ exerciseName }}</h1>
  <p>Equipment: TODO Equipment</p>

  <!-- TODO Split the rest of the space into 3 equal parts -->
  <div class="row">
    <!-- TODO Clock countdown/reps/duration -->
  </div>
  <div class="row">
    <!-- TODO Video/instructions -->
  </div>
  <div class="row">
    <!-- TODO Rep stuff -->
    <button type="button" class="btn btn-success btn-lg">Continue</button>
    <!-- TODO make the button not cross the whole screen -->
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
