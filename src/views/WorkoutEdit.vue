<script setup>
import workoutEditExerciseEdit from '../components/WorkoutEditExerciseEdit.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { gql } from "@apollo/client/core";
import { useRoute } from 'vue-router'
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("router params", routeObj.params)

// TODO load page with existing workouts
// TODO when saving update exiting workouts

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

// all exercisesdata
let exercisesData = ref([])
// for each exercise
workout.exercises.forEach(element => {
  console.log('getting exercise data', element)
  //    run query to get all data
  client.query({
    query: getExercise,
    variables: {exercisesId: element},    
    fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
  })
  .then(result => {
    console.log("results", result)
    console.log("result.data.exercises[0]", result.data.exercises[0])

    //    save in new object via push
    exercisesData.value.push(result.data.exercises[0])
    console.log("exercisesData", exercisesData.value)
  })
})

// TODO down below use new object to show data


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
  <input type="text" class="form-control" id="workoutDescription" v-model="workout.description" aria-label="Workout Description" />

  <!-- I think part of the problem is we are only pulling back a number not the whole object -->
  <div v-for="exercise in exercisesData" :key="exercise">
    <workout-edit-exercise-edit :name="exercise.name" :sets="exercise.sets" :reps="exercise.reps" :duration="exercise.duration" :rest="exercise.rest"></workout-edit-exercise-edit>
  </div>

  <div class="row">
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
