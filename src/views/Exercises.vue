<script setup>
import cardView from '../components/CardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { ref } from "vue"

let getExercises = gql`
  query Query {
    exercises {
      id
      name
      video
      picture
      instructions
      difficulty
      musclegroups {
        id
        name
        picture
      }
      reps
      duration
      equipment {
        id
        name
        icon
      }
    }
  }
` 

const exercises = ref([])

client.query({
  query: getExercises,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("results", result)
  exercises.value = structuredClone(result.data.exercises)
  console.log("exercises", exercises)
})

</script>

<template>
  <form class="d-flex">
    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" />
    <button class="btn btn-outline-primary" type="submit">Search</button>
  </form>
  <!-- height: calc(100% vertical height - Nav bar (56px) - Search bar (38px) - New exercise btn (38px) - IDK-DIK (16px) - Card margin (0.5rem) - Toolbar margin (0.5rem) -->
  <div style="position: relative; height: calc(100vh - 56px - 38px - 38px - 16px - 0.5rem - 0.5rem); margin-top: 0.5rem; overflow: auto">
    <div v-for="exercise in exercises" :key="exercise">
      <card-view :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :description="exercise.instructions" :exerciseid="exercise.id"></card-view>
    </div>
  </div>
  <button type="button" class="btn btn-outline-secondary">New Exercise</button>
</template>

<style scoped>
div.card-view:last-child div.card {
  margin-bottom: 0 !important;
}
</style>
