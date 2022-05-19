<script setup>
import cardView from '../components/CardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { useRoute } from 'vue-router'
import { gql } from "@apollo/client/core";
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("exercise edit router params", routeObj.params)

let exercise = JSON.parse(routeObj.params.exercise)
console.log (exercise)

</script>

<template>
  <h1>{{ exercise.name }}</h1>
  <img src="/pic1.jpg" alt="pic1" style="max-width: 94vw; padding-top: 15px; padding-bottom: 15px" />

  <div class="row align-items-start" style="padding-bottom: 20px">
    <div class="col">
      <button type="button" class="btn btn-outline-primary">Upload Photo</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-warning">Remove Photo</button>
    </div>
  </div>

  <div style="padding-bottom: 20px">
    <h4>Instructions</h4>
    <input type="text" class="form-control" id="workoutDescription" v-model="exercise.instructions" aria-label="Workout Description" />
  </div>

  <!-- Need to determine how show and edit the below fields -->
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

  <div style="padding-bottom: 10px">
    <button type="button" class="btn btn-primary" @click="saveWorkoutClick()">Save</button>
  </div>
</template>

<style scoped>
</style>
