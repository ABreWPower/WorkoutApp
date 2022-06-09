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

  // Set a mutation to use
  let mutationToUse = null
  if (workout.value.id == null) {
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
      id: parseInt(workout.value.id),
      name: workout.value.name,
      picture: workout.value.picture,
      description: workout.value.description,
      user: workout.value.user,
      exercises: workout.value.exercises.flatMap((element, index) => [{
        id: parseInt(element.id),
        reps: element.reps,
        sets: element.sets,
        duration: element.duration,
        rest: element.rest,
        sort: index
      }])
    }
  })
  .then(result => {
    console.log("results", result)
    if (workout.value.id == null) {
      workout.value.id = result.data.addWorkout.id
      console.log("workout id", workout.value.id)
      router.push({
        name: 'Edit Workout',
        params: {
          workout: JSON.stringify(workout.value),
          workoutid: workout.value.id
        }
      })
    }
    else {
      console.log("nothing to do with returned id as we already have it")
    }
    // TODO probably do something to let user know it succeded
  })

  console.log("after save workout")
}

// *********************
//  Other Button section
// *********************

const addExerciseClick = () => {
  console.log("add exercise click")
  console.log("workout", workout.value)

  router.push({ 
    name: 'Exercises',
    params: {
      mode: "AddExerciseToWorkout",
      workout: JSON.stringify(workout.value)
    }
  })
}

function exerciseMove(fromIndex, offset) {
  if(fromIndex + offset < 0 || fromIndex + offset >= workout.value.exercises.length) {
    return
  }
  let arr = workout.value.exercises
  let element = arr[fromIndex]
  arr.splice(fromIndex, 1)
  arr.splice(fromIndex + offset, 0, element)
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
  <div v-for="(exercise, index) in workout.exercises" :key="exercise.id">
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
      @delete="workout.exercises.splice(workout.exercises.indexOf(exercise), 1)"
      @move:up="exerciseMove(index, -1)"
      @move:down="exerciseMove(index, 1)"
    >
    </workout-edit-exercise-card-view>
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