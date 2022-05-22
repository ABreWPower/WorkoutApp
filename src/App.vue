<script setup>
import { RouterLink, RouterView, useRoute } from "vue-router"
import  { ref, watch } from "vue"

const routeObj = useRoute()
const pageTitle = ref('Workout App')
watch(routeObj, () => {
  // console.log(routeObj.name)
  pageTitle.value = routeObj.name
})

// Click handler for opening and closing nav bar
let navBarToggle = false
function navBarButtonClick() {
  let navBar = document.getElementById("navbarSupportedContent")
  if (navBarToggle == false) {
    navBar.style.display = "block"
    navBarToggle = true
  }
  else {
    navBar.style.display = "none"
    navBarToggle = false
  }
}

// Close the nav bar on routing
function closeNavBar() {
  let navBar = document.getElementById("navbarSupportedContent")
  navBar.style.display = "none"
  navBarToggle = false
}
</script>

<template>
  <!-- TODO close dropdown menu after a selection -->
  <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-primary mb-2" style="color: white; padding-left: 20px; padding-right 20px;">
    <div class="container-fluid">
      <div class="mx-3">
        <button class="navbar-toggler" type="button" @click="$router.go(-1)">
          <i class="bi bi-arrow-left"></i>
        </button>
      </div>
      <h2>{{ pageTitle }}</h2>
      <!-- <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> -->
      <button class="navbar-toggler" type="button" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" @click="navBarButtonClick()">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <p style="color: white; padding-left: 20px; padding-right 20px;">Workout App</p>
          </li>
          <!-- data-bs-toggle="collapse" data-bs-target=".navbar-collapse"  broke the links -->
          <li class="nav-item" @click="closeNavBar()">
            <router-link to="/" style="color: white; padding-left: 20px; padding-right 20px;">Workouts</router-link>
          </li>
          <li class="nav-item" @click="closeNavBar()">
            <router-link to="/exercises" style="color: white; padding-left: 20px; padding-right 20px;">Exercises</router-link>
          </li>
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

/* a,
p,
h2 {
  color: white;
} */
</style>
