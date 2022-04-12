<script setup>
import cardView from '../components/CardView.vue'
import { useRoute } from 'vue-router'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { ref } from "vue"

import Workout1Pic from "/pic1.jpg"
import Workout2Pic from "/pic2.jpg"
import Workout3Pic from "/pic3.jpg"

const getImages = function () {
  let images = [Workout1Pic, Workout2Pic, Workout3Pic];
  return images[Math.floor(Math.random() * images.length)];
}

const routeObj = useRoute()
console.log("exerciseid from router", routeObj.params.exerciseid)

let getExercise = gql`
  query Query {
    exercises(id: ${routeObj.params.exerciseid}) {
      id
      name
      video
      picture
      instructions
      musclegroups {
        id
        name
        picture
      }
      difficulty
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

const exercise = ref([])
const equipment = ref([])
const musclegroups = ref([])

client.query({
  query: getExercise,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("results", result)
  exercise.value = structuredClone(result.data.exercises[0])
  console.log("exercise", exercise)
  console.log("exercise.equipment", result.data.exercises[0].equipment)
  result.data.exercises[0].equipment.forEach(element => {
    console.log("equipment", element)
    equipment.value.push(element.name)
  })
  console.log("exercise.musclegroups", result.data.exercises[0].musclegroups)
  result.data.exercises[0].musclegroups.forEach(element => {
    console.log("musclegroups", element)
    musclegroups.value.push(element.name)
  })
})
</script>

<template>
  <h1>{{ exercise.name }}</h1>
  <!-- <img src="/pic1.jpg" alt="pic1" style="max-width: 100vw" /> -->
  <img v-bind:src="getImages(picture)" v-bind:alt="name" class="img-fluid rounded-start w-100" style="" />

  <div class="row align-items-start">
    <div class="col">
      <p>Muscle Group: {{ musclegroups }}</p>
    </div>
    <div class="col">
      <div class="row align-items-start">
        <p>
          Difficulty:
          <span v-for="i in [0, 1, 2]" :key="i">
            <i v-if="i < exercise.difficulty" class="bi bi-star-fill"></i>
            <i v-else class="bi bi-star"></i>
          </span>
        </p>
      </div>
    </div>
  </div>

  <div class="row align-items-start">
    <div class="col">
      <p>Duration: {{ exercise.duration }} minutes</p>
    </div>
    <div class="col">
      <p>Required Equipment: {{ equipment }}</p>
    </div>
  </div>

  <h4>Description</h4>
  <p>
    {{ exercise.instructions }}
  </p>

  <!-- <div v-for="exercise in workout.exercises" :key="exercise">
    <card-view :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :description="exercise.instructions" :exerciseid="exercise.id"></card-view>
  </div> -->

  <!-- <div class="row">
    <div class="col">
      <button type="button" class="btn btn-primary">Start</button>
    </div> 
    <div class="col"> -->
  <button type="button" class="btn btn-outline-secondary">Edit</button>
  <!-- </div>
  </div> -->
</template>

<style scoped>
</style>
