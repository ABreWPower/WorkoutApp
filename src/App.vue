<template id="main-page">
  <v-ons-page>
    <NavBar
      v-bind:title="page"
      v-bind:page="page"
      v-bind:pages="pages"
      v-on:newPage="page = String($event)"
    >
      <component v-bind:is="page"></component>
    </NavBar>
  </v-ons-page>
</template>

<style>
/* CSS goes here */
</style>

<script>
import NavBar from './components/NavBar.vue'
import Workouts from './components/Workouts.vue'
import Exercises from './components/Workouts.vue'
import Settings from './components/Workouts.vue'
import About from './components/Workouts.vue'
import Profile from './components/Workouts.vue'

export default {
  name: 'App',
  data: function() {
    return {
      page: 'Workouts',
      pages: ['Workouts', 'Exercises', 'Settings', 'About', 'Profile']
    }
  },
  components: { NavBar, Workouts, Exercises, Settings, About, Profile }
}
</script>
