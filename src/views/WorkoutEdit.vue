<script setup>
import workoutEditExerciseEdit from '../components/WorkoutEditExerciseEdit.vue'
import { client } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";

var workout = {
  id: null,
  name: 'New Workout',
  picture: 'TODO Something',
  description: 'A new workout',
  user: 0
}

let updateWorkout = gql`
  mutation Mutation($name: String!, $description: String, $user: Int) {
    addWorkout(name: $name, description: $description, user: $user) {
      id
    }
  }
` 

// const workouts = ref([])

const saveWorkoutClick = () => {
  console.log("before save workout")

  client.mutate({
    mutation: updateWorkout,
    variables: workout
  })
  .then(result => {
    console.log("results", result)
    // workouts.value = structuredClone(result.data.workouts)
    console.log("workouts", workouts)
  })

  console.log("after save workout")
}
</script>

<template>
  <div class="input-group input-group-lg">
    <span class="input-group-text" id="workoutNameLabel">Workout Name</span>
    <input type="text" class="form-control" id="workoutName" :value="workout.name" aria-label="Workout Name" aria-describedby="workoutNameLabel" />
  </div>
  <img src="/pic1.jpg" alt="pic1" />

  <div class="row align-items-start">
    <div class="col">
      <button type="button" class="btn btn-outline-primary">Upload Photo</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-warning">Remove Photo</button>
    </div>
  </div>

  <h4>Description</h4>
  <input type="text" class="form-control" id="workoutDescription" :value="workout.description" aria-label="Workout Description" />

  <div v-for="exercise in exercises" :key="exercise">
    <workout-edit-exercise-edit :name="exercise.name" :sets="exercise.sets" :reps="exercise.reps" :duration="exercise.duration" :rest="exercise.rest"></workout-edit-exercise-edit>
  </div>

  <div class="row">
    <div class="col">
      <button type="button" class="btn btn-outline-secondary">Add Exercise</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-primary" @click="saveWorkoutClick()">Save</button>
    </div>
  </div>
</template>

<style scoped>
</style>
