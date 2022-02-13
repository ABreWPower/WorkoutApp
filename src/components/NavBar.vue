<template id="NavBar">
  <v-ons-toolbar>
    <div class="left">
      <v-ons-toolbar-button @click="back">
        <v-ons-icon icon="md-arrow-left"></v-ons-icon>
      </v-ons-toolbar-button>
    </div>
    <div class="center">{{ title }}</div>
    <div class="right">
      <v-ons-toolbar-button @click="menuAction">
        <v-ons-icon icon="md-menu"></v-ons-icon>
      </v-ons-toolbar-button>
    </div>
  </v-ons-toolbar>
</template>

<script>
export default {
  name: 'NavBar',
  props: {
    title: String
  }
}
</script>

<style scoped>
</style>
