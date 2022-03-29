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
  console.log("workout.equipment", workout.equipment)
  workout.equipment.forEach(element => {
    console.log("equipment", element)
    equipment.push(element.name)
  })
})





// const workout = {
//   id: 1,
//   name: 'Workout 1',
//   picture: 'TODO Something',
//   description: 'A new workout',
//   user: 'default',
//   duration: 1800,
//   difficulty: 1,
//   equipment: ['barbell', 'dip machine']
// }

// const exercises = {
//   1: {
//     id: 1,
//     name: 'Exercise 1',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'Pushups while standing on the celling',
//     difficulty: 3,
//     muscleGroup: ['chest', 'gravity manipulation'],
//     reps: 10,
//     duration: 0,
//     equipment: ['anti-grav machine']
//   },
//   2: {
//     id: 2,
//     name: 'Exercise B',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'Chinups on a bench',
//     difficulty: 3,
//     muscleGroup: ['chest', 'gravity manipulation'],
//     reps: 10,
//     duration: 0,
//     equipment: ['bench']
//   },
//   3: {
//     id: 3,
//     name: 'Exercise 3C',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'walk in circles',
//     difficulty: 0,
//     muscleGroup: ['chest', 'gravity manipulation'],
//     reps: 10,
//     duration: 0,
//     equipment: ['ground']
//   },
//   4: {
//     id: 4,
//     name: 'Exercise 5',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'Crunches on the floor',
//     difficulty: 1,
//     muscleGroup: ['abs'],
//     reps: 15,
//     duration: 0,
//     equipment: []
//   },
//   5: {
//     id: 4,
//     name: 'Exercise 5',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'Crunches on the floor',
//     difficulty: 1,
//     muscleGroup: ['abs'],
//     reps: 15,
//     duration: 0,
//     equipment: []
//   }  ,
//   6: {
//     id: 4,
//     name: 'Exercise 5',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'Crunches on the floor',
//     difficulty: 1,
//     muscleGroup: ['abs'],
//     reps: 15,
//     duration: 0,
//     equipment: []
//   }  ,
//   7: {
//     id: 4,
//     name: 'Exercise 5',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'Crunches on the floor',
//     difficulty: 1,
//     muscleGroup: ['abs'],
//     reps: 15,
//     duration: 0,
//     equipment: []
//   },
//   8: {
//     id: 4,
//     name: 'Exercise 5',
//     picture: 'TODO Something',
//     video: 'TODO Something',
//     instructions: 'Crunches on the floor',
//     difficulty: 1,
//     muscleGroup: ['abs'],
//     reps: 15,
//     duration: 0,
//     equipment: []
//   }
// }
</script>

<template>
  <h1>{{ workout.name }}</h1>
  <!-- <img src="/pic1.jpg" alt="pic1" style="max-width: 100vw" /> -->

  <div class="row align-items-start">
    <div class="col">Duration: {{ workout.duration / 60 }} min</div>
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
    <card-view :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :description="exercise.instructions"></card-view>
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
