<script setup>
import { RouterLink, RouterView, useRoute } from "vue-router"
import  { ref, watch } from "vue"

const routeObj = useRoute()
const pageTitle = ref('Workout App')
watch(routeObj, () => {
  // console.log(routeObj.name)
  pageTitle.value = routeObj.name
})
</script>

<template>
  <!-- TODO close dropdown menu after a selection -->
  <!-- TODO need to get the back button to match the rest of the nav bar -->
  <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-primary mb-2">
    <div class="container-fluid">
      <div class="mx-3">
        <button class="navbar-toggler" type="button" @click="$router.go(-1)">
          <i class="bi bi-arrow-left"></i>
        </button>
      </div>
      <!-- <a class="navbar-brand" href="#">{{ pageTitle }}</a> -->
      <h2>{{ pageTitle }}</h2>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <p>Workout App</p>
          </li>
          <!-- data-bs-toggle="collapse" data-bs-target=".navbar-collapse"  broke the links -->
          <li class="nav-item">
            <router-link to="/">Workouts</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/exercises">Exercises</router-link>
          </li>
          <!-- Temp items -->
          <li class="nav-item">
            <router-link to="/workoutview">Workout View</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/workoutedit">Workout Edit</router-link>
          </li>
          <!-- temp items end -->
        </ul>
      </div>
    </div>
  </nav>

  <div class="container">
    <router-view />
  </div>
</template>

<style>
/* @import "@/assets/base.css"; */

a,
p,
h2 {
  color: white;
}
</style>
