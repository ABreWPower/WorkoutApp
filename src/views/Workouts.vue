<script setup>
import cardView from '../components/CardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { ref } from "vue"
import router from "../router/router.js"

let getWorkouts = gql`
  query Query {
    workouts {
      id
      name
      picture
      description
    }
  }
` 

const workouts = ref([])

client.query({
  query: getWorkouts,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("results", result)
  workouts.value = structuredClone(result.data.workouts)
  console.log("workouts", workouts)
})

const newWorkoutClick = () => {
    console.log("before new workout")
    router.push({ name: 'Add Workout' })
    console.log("after router push for new workout")
}
</script>

<template>
  <form class="d-flex">
    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" />
    <!-- <button class="btn btn-outline-primary" type="submit">Search</button> -->
  </form>
  <!-- height: calc(100% vertical height - Nav bar (56px) - Search bar (38px) - New workout btn (38px) - IDK-DIK (16px) - Card margin (0.5rem) - Toolbar margin (0.5rem) -->
  <div v-bind="$attrs" style="position: relative; height: calc(100vh - 56px - 38px - 38px - 16px - 0.5rem - 0.5rem); margin-top: 0.5rem; overflow: auto">
    <div v-for="workout in workouts" :key="workout" class="card-view">
      <card-view :name="workout.name" :picture="workout.picture" :description="workout.description" :workoutid="workout.id"></card-view>
    </div>
  </div>
  <button type="button" class="btn btn-outline-secondary mt-2" @click="newWorkoutClick()">New Workout</button>
</template>

<style scoped>
div.card-view:last-child div.card {
  margin-bottom: 0 !important;
}
</style>
