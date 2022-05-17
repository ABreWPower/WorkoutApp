<script setup>
import workoutEditExerciseEdit from '../components/WorkoutEditExerciseCardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("router params", routeObj.params)

// TODO load page with existing workouts (When the page is refreshed it loses the content)
//    Thought for this is to pass in the id like we do on workout view, but if we don't find some data from the object go fetch the thing?
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
  mutation Mutation($name: String!, $description: String, $user: Int, $exercises: [WorkoutExerciseInput]) {
    addWorkout(name: $name, description: $description, user: $user, exercises: $exercises) {
      id
    }
  }
`

let updateWorkout = gql`
  mutation Mutation($id: Int!, $name: String!, $description: String, $user: Int, $exercises: [WorkoutExerciseInput]) {
    updateWorkout(id: $id, name: $name, description: $description, user: $user, exercises: $exercises) {
      id
    }
  }
`

const saveWorkoutClick = () => {
  console.log("before save workout", workout)
  console.log("exercises", workout.exercises)
  console.log("type of", typeof workout.exercises)
  console.log("flatmap", workout.exercises.flatMap(element => [{id: element.id}]))

  // Set a mutation to use
  let mutationToUse = null
  if (workout.id == null) {
    console.log("no id, setting to use addWorkout")
    mutationToUse = addWorkout
  }
  else {
    console.log("found id, using updateWorkout")
    mutationToUse = updateWorkout
  }

  client.mutate({
    mutation: mutationToUse,
    variables: {
      id: parseInt(workout.id),
      name: workout.name,
      picture: workout.picture,
      description: workout.description,
      user: workout.user,
      exercises: workout.exercises.flatMap(element => [{id: parseInt(element.id)}])
    }
  })
  .then(result => {
    console.log("results", result)
    if (workout.id == null) {
      workout.id = result.data.addWorkout.id
      console.log("workout id", workout.id)
    }
    else {
      console.log("nothing to do with returned id as we already have it")
    }
    // TODO probably do something to let user know it succeded
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
