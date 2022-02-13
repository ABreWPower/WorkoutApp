<template id="main-page">
  <v-ons-page>
    <v-ons-toolbar>
      <div class="center">This Shit Works?</div>
    </v-ons-toolbar>

    <p style="text-align: center">
      <v-ons-button @click="$ons.notification.alert('Hello World!')">
        Click me!
      </v-ons-button>
    </p>
    <MainPage msg="Welcome to Workout App"/>
  </v-ons-page>
</template>

<style>
  /* CSS goes here */
</style>

<script>
import MainPage from './components/MainPage.vue'

export default {
  name: 'App',
  components: {
    MainPage
  }
}
</script>
