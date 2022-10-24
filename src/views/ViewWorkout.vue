<script setup>
import cardView from '../components/CardView.vue'
import { useRoute } from 'vue-router'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("workout view router params", routeObj.params)
console.log("workoutid from router", routeObj.params.workoutid)

let getWorkout = gql`
  query Query($workoutsId: ID) {
    workouts(id: $workoutsId) {
      id
      name
      picture
      description
      duration_calculated
      difficulty
      circuit_rounds
      equipment {
        name
        icon
      }
      exercises {
        id
        type
        name
        instructions
        picture
        duration
        sets
        reps
        rest
      }
    }
  }
`

const workout = ref([])
const equipment = ref([])

client.query({
  query: getWorkout,
  variables: {workoutsId: routeObj.params.workoutid},
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  workout.value = structuredClone(result.data.workouts[0])
  result.data.workouts[0].equipment.forEach(element => {
    equipment.value.push(element)
  })
})

let startClick = function() {
  console.log("startClick")
  console.log("workoutid", workout.value.id)
  router.push({
    name: 'Start Workout',
    params: {
      workout: JSON.stringify(workout.value),
      workoutid: workout.value.id
    }
  })
}

let editClick = function() {
  console.log("editClick")
  console.log("workoutid", workout.value.id)
  router.push({
    name: 'Edit Workout',
    params: {
      workout: JSON.stringify(workout.value),
      workoutid: workout.value.id
    }
  })
}
</script>

<template>
  <h1>{{ workout.name }}</h1>
  <!-- <img src="/pic1.jpg" alt="pic1" style="max-width: 100vw" /> -->

  <div v-bind="$attrs" class="row align-items-start">
    <div class="col-4">Duration: {{ Math.round(workout.duration_calculated / 60) }} minutes</div>
    <div class="col-4">Circuit Rounds: {{ workout.circuit_rounds }}</div>
    <div class="col-4">
      Difficulty:
      <span v-for="i in [0, 1, 2]" :key="i">
        <i v-if="i < workout.difficulty" class="bi bi-star-fill" style="font-size: 25px; padding-right: 10px"></i>
        <i v-else class="bi bi-star" style="font-size: 25px; padding-right: 10px"></i>
      </span>
    </div>
  </div>

  <p>Required Equipment: {{ equipment.flatMap((element) => [element.name]).join(', ') }}</p>

  <h4>Description</h4>
  <p>
    {{ workout.description }}
  </p>

  <div v-for="exercise in workout.exercises" :key="exercise">
    <card-view :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :description="exercise.instructions" :exerciseid="exercise.id"></card-view>
  </div>

  <div class="row">
    <div class="col">
      <button type="button" class="btn btn-primary" @click="startClick()">Start</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-secondary" @click="editClick()">Edit</button>
    </div>
  </div>
</template>

<style scoped>
</style>
