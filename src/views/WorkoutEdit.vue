<script setup>
import workoutEditExerciseEdit from '../components/WorkoutEditExerciseCardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("router params", routeObj.params)

// TODO load page with existing workouts
// TODO when saving update exiting workouts
// Need to save the exercise reps, sets, etc in the database somewhere

var workout = {
  id: null,
  name: null,
  picture: null,
  description: null,
  exercises: [],
  user: 1
}

if(routeObj.params.workout !== undefined) {
  workout = JSON.parse(routeObj.params.workout)
  console.log("workout", workout)
}

let getExercise = gql`
  query Exercises($exercisesId: ID) {
    exercises(id: $exercisesId) {
      id
      name
      picture
      instructions
      difficulty
      reps
      duration
    }
  }
`

let addWorkout = gql`
  mutation Mutation($name: String!, $description: String, $user: Int, $exercises: [Int]) {
    addWorkout(name: $name, description: $description, user: $user, exercises: $exercises) {
      id
    }
  }
`

const savedWorkoutID = ref()

const saveWorkoutClick = () => {
  console.log("before save workout", workout)

  client.mutate({
    mutation: addWorkout,
    variables: workout
  })
  .then(result => {
    console.log("results", result)
    savedWorkoutID.value = result.data.addWorkout.id
    console.log("savedWorkoutID", savedWorkoutID.value)
  })

  console.log("after save workout")
}

const addExerciseClick = () => {
  console.log("add exercise click")
  console.log("workout", workout)

  router.push({ 
    name: 'Exercises',
    params: {
      mode: "AddExerciseToWorkout",
      workout: JSON.stringify(workout)
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

  <div class="row align-items-start" style="padding-bottom: 20px">
    <div class="col">
      <button type="button" class="btn btn-outline-primary">Upload Photo</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-warning">Remove Photo</button>
    </div>
  </div>

  <div style="padding-bottom: 20px">
    <h4>Description</h4>
    <input type="text" class="form-control" id="workoutDescription" v-model="workout.description" aria-label="Workout Description" />
  </div>

  <!-- I think part of the problem is we are only pulling back a number not the whole object -->
  <div v-for="exercise in workout.exercises" :key="exercise">
    <workout-edit-exercise-edit :name="exercise.name" :sets="exercise.sets" :reps="exercise.reps" :duration="exercise.duration" :rest="exercise.rest"></workout-edit-exercise-edit>
  </div>

  <div class="row" style="padding-bottom: 10px">
    <div class="col">
      <button type="button" class="btn btn-outline-secondary" @click="addExerciseClick()">Add Exercise</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-primary" @click="saveWorkoutClick()">Save</button>
    </div>
  </div>
</template>

<style scoped>
</style>
