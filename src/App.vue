<script setup>
import { RouterLink, RouterView } from "vue-router";

// // import NavBar from './views/NavBar.vue'
// import Workouts from './views/Workouts.vue'
// import Exercises from './views/Exercises.vue'
// // import Settings from './views/Settings.vue'
// // import About from './views/About.vue'
// // import Profile from './views/Profile.vue'

// import WorkoutPage from './views/WorkoutPage.vue'
// import WorkoutEdit from './views/WorkoutEdit.vue'

// const page = WorkoutEdit;
// const pages = [Workouts, Exercises, "Settings", "About", "Profile"];
</script>

<template>
  <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
      <button type="button" @click="$router.go(-1)">
        <i class="bi bi-arrow-left"></i>
      </button>
      <a class="navbar-brand" href="#">Workout App</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!-- <div class="navbar-nav mr-auto"> -->
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <router-link to="/">Workouts</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/exercises">Exercises</router-link>
          </li>
          <!-- Temp itesm -->
          <li class="nav-item">
            <router-link to="/workoutview">Workout View</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/workoutedit">Workout Edit</router-link>
          </li>
          <!-- temp items end -->
        </ul>
        <!-- </div> -->
      </div>
    </div>
  </nav>

  <router-view />
  <div class="container">
    <component v-bind:is="page"></component>
  </div>
</template>

<style>
/* @import "@/assets/base.css"; */

a {
  color: white;
}
</style>
