<script setup>
import cardView from '../components/CardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { useRoute } from 'vue-router'
import { gql } from "@apollo/client/core";
import { watch, ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("exercise router params", routeObj.params)

let workout = null
if(routeObj.params.workout !== undefined) {
  workout = JSON.parse(routeObj.params.workout)
  console.log("workout", workout)
}

var cardClickHandler = undefined
if (routeObj.params.mode == "AddExerciseToWorkout") {
  console.log("Set Card Click Handler")
  // Click handler is for when we come from workout edit page and should only be set if a workout was passed in
  cardClickHandler = function(exercise) {  
    console.log("Card Click Handler")
    return function() {
      console.log("card click", exercise)
      workout.exercises.push(exercise)
      console.log("workout", workout)
      workout.id = parseInt(workout.id)

      router.push({
        name: "Edit Workout",
        params: {
          workout: JSON.stringify(workout),
          workoutid: workout.id
        }
      })
    }
  }
}

let getExercises = gql`
  query Query {
    exercises {
      id
      name
      video
      picture
      instructions
      difficulty
      musclegroups {
        id
        name
        picture
      }
      reps
      duration
      equipment {
        id
        name
        icon
      }
    }
  }
` 

const exercises = ref([])
const exercisesFiltered = ref([])

client.query({
  query: getExercises,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("results", result)
  exercises.value = structuredClone(result.data.exercises)
  exercisesFiltered.value = exercises.value
  console.log("exercises", exercises)
})

// Debounce and search function for exercises and the data returned from the database
let timerId
function debounce(functionName, delay, ...args) {
  clearTimeout(timerId)
  timerId = setTimeout(() => {functionName.apply(null, args)}, delay)
}

function search(searchFor) {
  console.log("we are seearching ", searchFor)
  exercisesFiltered.value = exercises.value.filter(function(element) {
    console.log("elelemtn", element.name, element.name == searchFor)
    let name = element.name.toLowerCase().includes(searchFor.toLowerCase())
    let instructions = element.instructions.toLowerCase().includes(searchFor.toLowerCase())
    let musclegroups = element.musclegroups.filter(subelement => subelement.name.toLowerCase().includes(searchFor.toLowerCase())).length
    let equipment = element.equipment.filter(subelement => subelement.name.toLowerCase().includes(searchFor.toLowerCase())).length
    return name || instructions || musclegroups || equipment
  })
}

let searchValue = ref("")
watch(searchValue, () => {
  console.log("my watcher changed")
  debounce(search, 1000, searchValue.value)
})

// Click handler
const newExerciseClick = () => {
    // console.log("before new exercise")
    router.push({ name: 'Add Exercise' })
    // console.log("after router push for new exercise")
}
</script>

<template>
  <form class="d-flex">
    <!-- TODO need to override the enter key (still refreshing page) -->
    <input class="form-control me-2" type="search" placeholder="Search" v-model="searchValue" />
    <p>{{ searchValue }}</p>
    <!-- <button class="btn btn-outline-primary" type="submit">Search</button> -->
  </form>
  <!-- height: calc(100% vertical height - Nav bar (56px) - Search bar (38px) - New exercise btn (38px) - IDK-DIK (16px) - Card margin (0.5rem) - Toolbar margin (0.5rem) -->
  <div v-bind="$attrs" style="position: relative; height: calc(100vh - 56px - 38px - 38px - 16px - 0.5rem - 0.5rem); margin-top: 0.5rem; overflow: auto">
    <div v-for="exercise in exercisesFiltered" :key="exercise">
      <card-view v-if="routeObj.params.mode != 'AddExerciseToWorkout'" :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :description="exercise.instructions" :exerciseid="exercise.id"></card-view>
      <card-view v-else :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :description="exercise.instructions" :exerciseid="exercise.id" :click-handler="cardClickHandler(exercise)"></card-view>
    </div>
  </div>
  <button type="button" class="btn btn-outline-secondary" @click="newExerciseClick()">New Exercise</button>
</template>

<style scoped>
div.card-view:last-child div.card {
  margin-bottom: 0 !important;
}
</style>
