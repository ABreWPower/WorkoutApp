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

const circuitCheckboxValue = ref(false)

// If we get an workout object passed in, overwrite the defaults
if(routeObj.params.workout !== undefined) {
  workout.value = JSON.parse(routeObj.params.workout)
  if (workout.value.circuit_rounds === undefined || workout.value.circuit_rounds == null || workout.value.circuit_rounds == 0 ) {
    workout.value.circuit_rounds = 1
  }
  if (workout.value.circuit_rounds > 1) {
    circuitCheckboxValue.value = true
  }
  if (workout.value.circuitRoundRest === undefined) {
    workout.value.circuitRoundRest = workout.value.exercises[workout.value.exercises.length - 1].rest
  }
  console.log("new workout object", workout.value)
}

let getWorkoutFromID = gql`
  query Query($workoutsId: ID) {
    workouts(id: $workoutsId) {
      id
      name
      picture
      description
      circuit_rounds
      exercises {
        id
        type
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
    if (workout.value.circuit_rounds === undefined || workout.value.circuit_rounds == null || workout.value.circuit_rounds == 0 ) {
      workout.value.circuit_rounds = 1
    }
    if (workout.value.circuit_rounds > 1) {
      circuitCheckboxValue.value = true
    }    
    if (workout.value.circuitRoundRest === undefined) {
      workout.value.circuitRoundRest = workout.value.exercises[workout.value.exercises.length - 1].rest
    }
    console.log("workout after load from server", workout.value)
  })
}

// **************
// Saving section
// **************

let addWorkout = gql`
  mutation Mutation($name: String!, $description: String, $circuit_rounds: Int, $user: Int, $exercises: [WorkoutExerciseInput]) {
    addWorkout(name: $name, description: $description, circuit_rounds: $circuit_rounds, user: $user, exercises: $exercises) {
      id
    }
  }
`

let updateWorkout = gql`
  mutation Mutation($id: Int!, $name: String!, $description: String, $circuit_rounds: Int, $user: Int, $exercises: [WorkoutExerciseInput]) {
    updateWorkout(id: $id, name: $name, description: $description, circuit_rounds: $circuit_rounds, user: $user, exercises: $exercises) {
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

  if (circuitCheckboxValue) {
    workout.value.exercises[workout.value.exercises.length -1].rest = parseInt(workout.value.circuitRoundRest)
  }

  client.mutate({
    mutation: mutationToUse,
    variables: {
      id: parseInt(workout.value.id),
      name: workout.value.name,
      picture: workout.value.picture,
      description: workout.value.description,
      circuit_rounds: circuitCheckboxValue.value ? parseInt(workout.value.circuit_rounds): 1,
      user: workout.value.user,
      exercises: workout.value.exercises.flatMap((element, index) => [{
        id: parseInt(element.id),
        type: element.type,
        reps: element.reps,
        sets: circuitCheckboxValue.value ? 1: element.sets,
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
  <div v-bind="$attrs" class="input-group input-group-lg">
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

  <!-- TODO the circuit stuff: checkbox to enable circuits, number of rounds, round rest (linked to last exercise rest time (needs to change when exercises added)) -->
  <div class="row" style="padding-bottom: 20px">
    <div class="col">
      <!-- <div class="input-group m-1 d-inline-flex align-items-center w-auto"> -->
      <div class="form-check mr-1 d-inline-flex align-items-center w-auto">
        <input class="form-check-input" type="checkbox" v-model="circuitCheckboxValue" id="circuitCheckbox" aria-label="Check the box to turn on circuits for the workout" />
      </div>
      <h3 class="m-1 d-inline-flex align-items-center w-auto">Circuit</h3>
      <!-- </div> -->
      <div class="input-group m-1 d-inline-flex align-items-center w-auto">
        <span class="input-group-text" id="circuitRountsLabel">Rounds</span>
        <input type="text" class="form-control" id="circuitRounds" v-model="workout.circuit_rounds" :readonly="!circuitCheckboxValue" aria-label="Number of Rounds in a Circuit" aria-describedby="circuitRountsLabel" style="max-width: 75px" />
      </div>
      <div class="input-group m-1 d-inline-flex align-items-center w-auto">
        <span class="input-group-text" id="circuitRestLabel">Round Rest</span>
        <input type="text" class="form-control" id="circuitRest" v-model="workout.circuitRoundRest" :readonly="!circuitCheckboxValue" aria-label="The amount of rest between rounds" aria-describedby="circuitRestLabel" style="max-width: 75px" />
      </div>
    </div>
  </div>

  <div v-for="(exercise, index) in workout.exercises" :key="exercise.id">
    <workout-edit-exercise-card-view
      :name="exercise.name"
      :typeIsWorkout="exercise.type == 'workout' ? true : false"
      :picture="exercise.picture"
      :sets="exercise.sets"
      :setsReadOnly="circuitCheckboxValue"
      @update:sets="exercise.sets = parseInt($event)"
      :reps="exercise.reps"
      @update:reps="exercise.reps = parseInt($event)"
      :duration="exercise.duration"
      @update:duration="exercise.duration = parseInt($event)"
      :rest="exercise.rest"
      :restReadOnly="index == workout.exercises.length - 1 && circuitCheckboxValue"
      @update:rest="exercise.rest = parseInt($event)"
      @delete="workout.exercises.splice(workout.exercises.indexOf(exercise), 1)"
      @move:up="exerciseMove(index, -1)"
      @move:down="exerciseMove(index, 1)">
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
input[type='checkbox'] {
  transform: scale(1.25);
}
</style>
