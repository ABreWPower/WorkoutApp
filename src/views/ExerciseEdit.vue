<script setup>
import cardView from '../components/CardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { useRoute } from 'vue-router'
import { empty, gql } from "@apollo/client/core";
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("exercise edit router params", routeObj.params)

// ********************
// Data loading section
// ********************

const exercise = ref({
  id: null,
  name: null,
  musclegroups: [],
  equipment: []
})

// If we get an exercise object passed in, overwrite the defaults
if(routeObj.params.exercise !== undefined) {
  exercise.value = JSON.parse(routeObj.params.exercise)
  console.log("new exercise object", exercise.value)
}

let getExercise = gql`
  query Query($exercisesId: ID) {
    exercises(id: $exercisesId) {
      id
      name
      video
      picture
      instructions
      musclegroups {
        id
        name
        picture
      }
      difficulty
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

if (routeObj.params.exerciseid != null && exercise.value.name == null) {
  console.log("page was refreshed, pulling data")
  client.query({
    query: getExercise,
    variables: { exercisesId: parseInt(routeObj.params.exerciseid)},
    fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
  })
  .then(result => {
    console.log("results", result)
    exercise.value = structuredClone(result.data.exercises[0])
    console.log("exercise", exercise)
    console.log("exercise.equipment", result.data.exercises[0].equipment)
    result.data.exercises[0].equipment.forEach(element => {
      equipmentCheckChange(element)
    })
    console.log("exercise.musclegroups", result.data.exercises[0].musclegroups)
    result.data.exercises[0].musclegroups.forEach(element => {
      muscleGroupCheckChange(element)
    })
  })
}

// TODO need to match up the existing equipment and musclegroups

// **********************
// Array Removal Function
// **********************
function arrayRemove(arr, value) { 
    return arr.filter( function(element) {
        return element != value; 
    })
}

// *************
// Muscle Groups
// *************

// Pull all of the muscle groups from the database use show the user
let getMuscleGroups = gql`
  query Musclegroups {
    musclegroups {
      id
      name
      picture
    }
  }
`

const muscleGroupsList = ref([])

client.query({
  query: getMuscleGroups,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("exercise muscleGroupsList", result.data.musclegroups)
  result.data.musclegroups.forEach(element => {
    // console.log("muscleGroupsList add", element)
    muscleGroupsList.value.push(element)
  })
})

// Enable and disable the muscle group form
let muscleGroupToggle = false
function muscleGroupDropdown() {
  let dropdown = document.getElementById("muscleGroupForm")
  if (muscleGroupToggle == false) {
    dropdown.style.display = "block"
    muscleGroupToggle = true
  }
  else {
    dropdown.style.display = "none"
    muscleGroupToggle = false
  }
}

// Add each clicked item to the exercise.musclegroups
function muscleGroupCheckChange(musclegroup) {
  if (exercise.value.musclegroups.includes(musclegroup)) {
    // Remove the muscle group from the exercise
    exercise.value.musclegroups = arrayRemove(exercise.value.musclegroups, musclegroup)
  }
  else {
    // Add the muscle group to the exercise
    exercise.value.musclegroups.push(musclegroup)
  }
}

// *********
// Equipment
// *********

// Pull all of the equipment from the database use show the user
let getEquipment = gql`
  query Equipment {
    equipment {
      id
      name
      icon
    }
  }
`

const equipmentList = ref([])

client.query({
  query: getEquipment,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("exercise equipment", result.data.equipment)
  result.data.equipment.forEach(element => {
    // console.log("equipmentList add", element)
    equipmentList.value.push(element)
  })
})

// Enable and disable the equipment form
let equipmentToggle = false
function equipmentDropdown() {
  let dropdown = document.getElementById("equipmentForm")
  if (equipmentToggle == false) {
    dropdown.style.display = "block"
    equipmentToggle = true
  }
  else {
    dropdown.style.display = "none"
    equipmentToggle = false
  }
}

// Add each clicked item to the exercise.musclegroups
function equipmentCheckChange(piece) {
  if (exercise.value.equipment.includes(piece)) {
    // Remove the muscle group from the exercise
    exercise.value.equipment = arrayRemove(exercise.value.equipment, piece)
  }
  else {
    // Add the muscle group to the exercise
    exercise.value.equipment.push(piece)
  }
}

// **************
// Saving section
// **************

let addExercise = gql`
  mutation Mutation($name: String!, $video: String, $picture: String, $instructions: String, $difficulty: Int, $musclegroups: [Int], $reps: Int, $duration: Int, $equipment: [Int]) {
    addExercise(name: $name, video: $video, picture: $picture, instructions: $instructions, difficulty: $difficulty, musclegroups: $musclegroups, reps: $reps, duration: $duration, equipment: $equipment) {
      id
    }
  }
`

let updateExercise = gql`
  mutation UpdateExercise($id: Int!, $name: String!, $video: String, $picture: String, $instructions: String, $difficulty: Int, $musclegroups: [Int], $reps: Int, $duration: Int, $equipment: [Int]) {
    updateExercise(id: $id, name: $name, video: $video, picture: $picture, instructions: $instructions, difficulty: $difficulty, musclegroups: $musclegroups, reps: $reps, duration: $duration, equipment: $equipment) {
      id
    }
  }
`

const saveExerciseClick = () => {
  console.log("before save exercise", exercise.value)
  console.log("flatmap", exercise.value.musclegroups.flatMap(element => [element.id]))
  console.log("flatmap", exercise.value.equipment.flatMap(element => [element.id]))

  // Set a mutation to use
  let mutationToUse = null
  if (exercise.value.id == null) {
    console.log("no id, setting to use addExercise")
    mutationToUse = addExercise
  }
  else {
    console.log("found id, using updateExercise")
    mutationToUse = updateExercise
  }

  client.mutate({
    mutation: mutationToUse,
    variables: {
      id: parseInt(exercise.value.id),
      name: exercise.value.name,
      picture: exercise.value.picture,
      video: exercise.value.video,
      instructions: exercise.value.instructions,
      difficulty: exercise.value.difficulty,
      reps: exercise.value.reps,
      duration: exercise.value.duration,
      equipment: exercise.value.equipment.flatMap(element => [parseInt(element.id)]),
      musclegroups: exercise.value.musclegroups.flatMap(element => [parseInt(element.id)])
    }
  })
  .then(result => {
    console.log("results", result)
    if (exercise.value.id == null) {
      exercise.value.id = result.data.addExercise.id
      console.log("exercise id", exercise.value.id)
      router.push({
        name: 'Exercise Edit',
        params: {
          exercise: JSON.stringify(exercise.value),
          exerciseid: exercise.value.id
        }
      })
    }
    else {
      console.log("nothing to do with returned id as we already have it")
    }
    // TODO probably do something to let user know it succeded
  })

  console.log("after save exercise")
}
</script>

<template>
  <!-- TODO sorta need to make this editable -->
  <div class="input-group input-group-lg">
    <span class="input-group-text" id="exerciseNameLabel">Exercise Name</span>
    <input type="text" class="form-control" id="exerciseName" v-model="exercise.name" aria-label="Exercise Name" aria-describedby="exerciseNameLabel" />
  </div>
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
    <h4>Instructions</h4>
    <input type="text" class="form-control" id="exerciseDescription" v-model="exercise.instructions" aria-label="Exercise Description" />
  </div>

  <div class="dropdown" style="padding-bottom: 20px">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="muscleGroupDropdown" @click="muscleGroupDropdown()" aria-haspopup="true" aria-expanded="false">Muscle Groups</button>
    <div class="dropdown-menu" aria-labelledby="muscleGroupDropdown" id="muscleGroupForm">
      <div v-for="musclegroup in muscleGroupsList" :key="musclegroup.id">
        <!-- TODO checked property not working yet -->
        <input type="checkbox" class="custom-control-input" :id="musclegroup.id" @click="muscleGroupCheckChange(musclegroup)" :checked="exercise.musclegroups.includes(musclegroup)" />
        <label class="custom-control-label" :for="musclegroup.id"> {{ musclegroup.name }} </label>
      </div>
    </div>
  </div>

  <!-- TODO make this an input and start with incoming values -->
  <div class="" style="padding-bottom: 10px">
    <p>
      Difficulty:
      <span v-for="i in [0, 1, 2]" :key="i">
        <i v-if="i < exercise.difficulty" class="bi bi-star-fill" style="font-size: 25px; padding-right: 10px"></i>
        <i v-else class="bi bi-star" style="font-size: 25px; padding-right: 10px"></i>
      </span>
    </p>
  </div>

  <!-- TODO lock 1 down after the other is filled in Reps/Duration -->
  <div v-if="reps != 0" class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto" style="padding-bottom: 10px">
    <span class="input-group-text" id="repsText" style="width: 75px">Reps</span>
    <input type="number" v-model="exercise.reps" class="form-control" aria-describedby="repsText" style="max-width: 75px" />
  </div>
  <div v-if="duration != 0" class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto" style="padding-bottom: 10px">
    <span class="input-group-text" id="durationText" style="width: 75px">Duration</span>
    <input type="number" v-model="exercise.duration" class="form-control" placeholder="Seconds" aria-describedby="durationText" style="max-width: 75px" />
  </div>

  <div class="dropdown" style="padding-bottom: 20px">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="equipmentDropdown" @click="equipmentDropdown()" aria-haspopup="true" aria-expanded="false">Equipment</button>
    <div class="dropdown-menu" aria-labelledby="equipmentDropdown" id="equipmentForm">
      <div v-for="piece in equipmentList" :key="piece.id">
        <input type="checkbox" class="custom-control-input" :id="piece.id + 1000" @click="equipmentCheckChange(piece)" />
        <label class="custom-control-label" :for="piece.id + 1000"> {{ piece.name }} </label>
      </div>
    </div>
  </div>

  <div style="padding-bottom: 10px">
    <button type="button" class="btn btn-primary" @click="saveExerciseClick()">Save</button>
  </div>
</template>

<style scoped>
</style>
