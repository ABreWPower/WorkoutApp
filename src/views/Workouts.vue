<script setup>
import cardView from '../components/CardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { watch, ref } from "vue"
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
const workoutsFiltered = ref([])

client.query({
  query: getWorkouts,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  // console.log("results", result)
  workouts.value = structuredClone(result.data.workouts)
  workoutsFiltered.value = workouts.value
  // console.log("workouts", workouts)
})

// Debounce and search function for workouts and the data returned from the database
let timerId
function debounce(functionName, delay, ...args) {
  clearTimeout(timerId)
  timerId = setTimeout(() => {functionName.apply(null, args)}, delay)
}

function search(searchFor) {
  // console.log("we are seearching ", searchFor)
  workoutsFiltered.value = workouts.value.filter(function(element) {
    // console.log("elelemtn", element.name, element.name == searchFor)
    let name = element.name.toLowerCase().includes(searchFor.toLowerCase())
    let description = element.description ? element.description.toLowerCase().includes(searchFor.toLowerCase()) : false
    return name || description
  })
}

let searchValue = ref("")
watch(searchValue, () => {
  // console.log("my watcher changed")
  debounce(search, 1000, searchValue.value)
})

const newWorkoutClick = () => {
    // console.log("before new workout")
    router.push({ name: 'Add Workout' })
    // console.log("after router push for new workout")
}
</script>

<template>
  <form class="d-flex">
    <input class="form-control me-2" type="search" placeholder="Search" v-model="searchValue" onkeypress="return event.keyCode != 13" />
    <!-- <button class="btn btn-outline-primary" type="submit">Search</button> -->
  </form>
  <!-- height: calc(100% vertical height - Nav bar (56px) - Search bar (38px) - New workout btn (38px) - IDK-DIK (16px) - Card margin (0.5rem) - Toolbar margin (0.5rem) -->
  <div v-bind="$attrs" style="position: relative; height: calc(100vh - 56px - 38px - 38px - 16px - 0.5rem - 0.5rem); margin-top: 0.5rem; overflow: auto">
    <div v-for="workout in workoutsFiltered" :key="workout" class="card-view">
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
