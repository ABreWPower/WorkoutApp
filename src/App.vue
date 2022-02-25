<script setup>
// import { RouterLink, RouterView } from "vue-router";

// import NavBar from './components/NavBar.vue'
import Workouts from './components/Workouts.vue'
import Exercises from './components/Exercises.vue'
// import Settings from './components/Settings.vue'
// import About from './components/About.vue'
// import Profile from './components/Profile.vue'

import WorkoutPage from './components/WorkoutPage.vue'

const page = WorkoutPage;
const pages = [Workouts, Exercises, "Settings", "About", "Profile"];
</script>

<template>
  <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
      <button type="button">
        <img src="icons/arrow-left.svg" alt="star" />
      </button>
      <a class="navbar-brand" href="#">Workout App</a>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!-- need to do a v-for over pages (once that data object works) -->
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li v-for="page in pages" :key="page">
            <a class="nav-link active" aria-current="page" href="#">{{
              page
            }}</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <component v-bind:is="page"></component>
</template>

<style>
@import "@/assets/base.css";
</style>
