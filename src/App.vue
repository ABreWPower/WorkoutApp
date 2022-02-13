<template id="main-page">
  <v-ons-page>
    <NavBar title="Testing"/>

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
import NavBar from './components/NavBar.vue'

export default {
  name: 'App',
  components: {
    MainPage,
    NavBar
  }
}
</script>
