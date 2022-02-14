<template id="main-page">
  <v-ons-page>
    <NavBar title="Testing">
      <MainPage></MainPage>
    </NavBar>
  </v-ons-page>
</template>

<style>
/* CSS goes here */
</style>

<script>
import NavBar from "./components/NavBar.vue";
import MainPage from "./components/MainPage.vue";

export default {
  name: "App",
  components: { NavBar, MainPage }
};
</script>
