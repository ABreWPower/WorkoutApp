<script setup>
import { RouterLink, RouterView } from "vue-router";

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
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
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
