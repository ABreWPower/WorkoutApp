<script setup>
import cardView from '../components/CardView.vue'
import { useRoute } from 'vue-router'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { ref } from "vue"

const route = useRoute()
console.log("workoutid from router", route.params.workoutid)

let getWorkout = gql`
  query Query {
    workouts(id: ${route.params.workoutid}) {
      id
      name
      picture
      description
      user {
        id
        name
        email
        avatar
      }
      duration
      difficulty
      equipment {
        id
        name
        icon
      }
      exercises {
        id
        name
        video
        instructions
        picture
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
  }
` 

const workout = ref([])
const equipment = ref([])

client.query({
  query: getWorkout,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("results", result)
  workout.value = structuredClone(result.data.workouts[0])
  console.log("workouts", workout)
  console.log("workout.equipment", result.data.workouts[0].equipment)
  result.data.workouts[0].equipment.forEach(element => {
    console.log("equipment", element)
    equipment.value.push(element.name)
  })
})
</script>

<template>
  <h1>{{ workout.name }}</h1>
  <!-- <img src="/pic1.jpg" alt="pic1" style="max-width: 100vw" /> -->

  <div class="row align-items-start">
    <div class="col">Duration: {{ workout.duration / 60 }} hours</div>
    <div class="col">
      <div class="row align-items-start">
        <p>
          Difficulty:
          <span v-for="i in [0, 1, 2]" :key="i">
            <i v-if="i < workout.difficulty" class="bi bi-star-fill"></i>
            <i v-else class="bi bi-star"></i>
          </span>
        </p>
      </div>
    </div>
  </div>

  <p>Required Equipment: {{ equipment }}</p>

  <h4>Description</h4>
  <p>
    {{ workout.description }}
  </p>

  <div v-for="exercise in workout.exercises" :key="exercise">
    <card-view :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :description="exercise.instructions" :exerciseid="exercise.id"></card-view>
  </div>

  <div class="row">
    <div class="col">
      <button type="button" class="btn btn-primary">Start</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-secondary">Edit</button>
    </div>
  </div>
</template>

<style scoped>
</style>
