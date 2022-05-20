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

let muscleGroup = false
function muscleGroupdropdown() {
  let dropdown = document.getElementById("muscleGroupForm")
  console.log(dropdown.display)
  if (muscleGroup == false) {
    dropdown.style.display = "block"
    muscleGroup = true
  }
  else {
    dropdown.style.display = "none"
    muscleGroup = false
  }
}

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

  <div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="muscleGroupDropdown" @click="muscleGroupdropdown()" aria-haspopup="true" aria-expanded="false">Muscle Groups</button>
    <div class="dropdown-menu" aria-labelledby="muscleGroupDropdown" id="muscleGroupForm">
      <form class="px-4 py-3">
        <div class="form-group">
          <label for="exampleDropdownFormEmail1">Email address</label>
          <input type="email" class="form-control" id="exampleDropdownFormEmail1" placeholder="email@example.com" />
        </div>
        <div class="form-group">
          <label for="exampleDropdownFormPassword1">Password</label>
          <input type="password" class="form-control" id="exampleDropdownFormPassword1" placeholder="Password" />
        </div>
        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="dropdownCheck" />
          <label class="form-check-label" for="dropdownCheck"> Remember me </label>
        </div>
        <button type="submit" class="btn btn-primary">Sign in</button>
      </form>
      <div class="dropdown-divider"></div>
      <a class="dropdown-item" href="#">New around here? Sign up</a>
      <a class="dropdown-item" href="#">Forgot password?</a>
    </div>
  </div>

  <div class="row align-items-start">
    <div class="col"></div>
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
