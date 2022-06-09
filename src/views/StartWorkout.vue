<script setup>
import workoutEditExerciseCardView from '../components/WorkoutEditExerciseCardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("workout edit router params", routeObj.params)

// ********************
// Data loading section
// ********************

const workout = ref({
  id: null,
  name: null,
  exercises: []
})

// If we get an workout object passed in, overwrite the defaults
if(routeObj.params.workout !== undefined) {
  workout.value = JSON.parse(routeObj.params.workout)
  console.log("new workout object", workout.value)
}

let getWorkoutFromID = gql`
  query Query($workoutsId: ID) {
    workouts(id: $workoutsId) {
      id
      name
      picture
      description
      exercises {
        id
        name
        picture
        instructions
        reps
        duration
        sets
        rest
      }
    }
  }
`

// If the object has property of id != null and name = null then we should assume the page was reloaded and need to pull down the data
// if (workout.id != null && workout.name == null) {
if (routeObj.params.workoutid != null && workout.value.name == null) {
  client.query({
    query: getWorkoutFromID,
    variables: { workoutsId: parseInt(routeObj.params.workoutid)},
    fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
  })
  .then(result => {
    console.log("results", result)
    console.log("result.data.workouts[0]", result.data.workouts[0])
    workout.value = JSON.parse(JSON.stringify(result.data.workouts[0]))
    console.log("workout after load from server", workout.value)
  })
}

// **************
// Saving section
// **************



// *********************
//  Other Button section
// *********************

let startClick = function() {
  console.log("startClick")
  console.log("workoutid", workout.value.id)
  router.push({
    name: 'Active Workout',
    params: {
      workout: JSON.stringify(workout.value),
      workoutid: workout.value.id
    }
  })
}

</script>

<template>
  <div class="input-group input-group-lg">
    <span class="input-group-text" id="workoutNameLabel">Workout Name</span>
    <input type="text" class="form-control" id="workoutName" v-model="workout.name" aria-label="Workout Name" aria-describedby="workoutNameLabel" />
  </div>
  <!-- Fix picture size like it is on the other pages, currently extending to far -->
  <img src="/pic1.jpg" alt="pic1" style="max-width: 94vw; padding-top: 15px; padding-bottom: 15px" />

  <h4>Description</h4>
  <p>
    {{ workout.description }}
  </p>

  <!-- I think part of the problem is we are only pulling back a number not the whole object -->
  <div v-for="exercise in workout.exercises" :key="exercise.id">
    <workout-edit-exercise-card-view
      :name="exercise.name"
      :picture="exercise.picture"
      :sets="exercise.sets"
      @update:sets="exercise.sets = parseInt($event)"
      :reps="exercise.reps"
      @update:reps="exercise.reps = parseInt($event)"
      :duration="exercise.duration"
      @update:duration="exercise.duration = parseInt($event)"
      :rest="exercise.rest"
      @update:rest="exercise.rest = parseInt($event)"
      :weight="exercise.weight"
      @update:weight="exercise.weight = parseInt($event)"
      :startWorkout="true">
    </workout-edit-exercise-card-view>
  </div>

  <div style="padding-bottom: 10px">
    <button type="button" class="btn btn-primary" @click="startClick()">Start</button>
  </div>
</template>

<style scoped>
</style>
