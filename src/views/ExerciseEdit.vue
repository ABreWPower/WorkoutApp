<script setup>
import cardView from '../components/CardView.vue'
import { client, forceNetworkJQL } from  "../scripts/connectGraphQL.js"
import { useRoute } from 'vue-router'
import { gql } from "@apollo/client/core";
import { ref } from "vue"
import router from "../router/router.js"

const routeObj = useRoute()
console.log("exercise edit router params", routeObj.params)

// ********************
// Data loading section
// ********************

const exercise = ref({
  id: null,
  name: null
})
const equipment = ref([])
const musclegroups = ref([])

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

console.log("a", routeObj.params.exerciseid)
console.log("b", exercise.value.name)
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
      console.log("equipment", element)
      equipment.value.push(element.name)
    })
    console.log("exercise.musclegroups", result.data.exercises[0].musclegroups)
    result.data.exercises[0].musclegroups.forEach(element => {
      console.log("musclegroups", element)
      musclegroups.value.push(element.name)
    })
  })
}

// TODO need to match up the existing equipment and musclegroups

// *************
// Muscle Groups
// *************

let muscleGroupToggle = false
function muscleGroupDropdown() {
  let dropdown = document.getElementById("muscleGroupForm")
  console.log(dropdown.display)
  if (muscleGroupToggle == false) {
    dropdown.style.display = "block"
    muscleGroupToggle = true
  }
  else {
    dropdown.style.display = "none"
    muscleGroupToggle = false
  }
}

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

// *********
// Equipment
// *********


let equipmentToggle = false
function equipmentDropdown() {
  let dropdown = document.getElementById("equipmentForm")
  console.log(dropdown.display)
  if (equipmentToggle == false) {
    dropdown.style.display = "block"
    equipmentToggle = true
  }
  else {
    dropdown.style.display = "none"
    equipmentToggle = false
  }
}

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
</script>

<template>
  <h1>{{ exercise.name }}</h1>
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
    <input type="text" class="form-control" id="workoutDescription" v-model="exercise.instructions" aria-label="Workout Description" />
  </div>

  <div class="dropdown" style="padding-bottom: 20px">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="muscleGroupDropdown" @click="muscleGroupDropdown()" aria-haspopup="true" aria-expanded="false">Muscle Groups</button>
    <div class="dropdown-menu" aria-labelledby="muscleGroupDropdown" id="muscleGroupForm">
      <div v-for="musclegroup in muscleGroupsList" :key="musclegroup.id">
        <input type="checkbox" class="custom-control-input" :id="musclegroup.id" />
        <label class="custom-control-label" :for="musclegroup.id"> {{ musclegroup.name }} </label>
      </div>
    </div>
  </div>

  <div class="" style="padding-bottom: 10px">
    <p>
      Difficulty:
      <span v-for="i in [0, 1, 2]" :key="i">
        <i v-if="i < exercise.difficulty" class="bi bi-star-fill"></i>
        <i v-else class="bi bi-star"></i>
      </span>
    </p>
  </div>

  <!-- TODO lock 1 down after the other is filled in Reps/Duration -->
  <div v-if="reps != 0" class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto" style="padding-bottom: 10px">
    <span class="input-group-text" id="repsText" style="width: 75px">Reps</span>
    <input type="number" :value="exercise.reps" class="form-control" aria-describedby="repsText" style="max-width: 75px" />
  </div>
  <div v-if="duration != 0" class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto" style="padding-bottom: 10px">
    <span class="input-group-text" id="durationText" style="width: 75px">Duration</span>
    <input type="number" :value="exercise.duration" class="form-control" placeholder="Seconds" aria-describedby="durationText" style="max-width: 75px" />
  </div>

  <div class="dropdown" style="padding-bottom: 20px">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="equipmentDropdown" @click="equipmentDropdown()" aria-haspopup="true" aria-expanded="false">Equipment</button>
    <div class="dropdown-menu" aria-labelledby="equipmentDropdown" id="equipmentForm">
      <div v-for="piece in equipmentList" :key="piece.id">
        <input type="checkbox" class="custom-control-input" :id="piece.id + 1000" />
        <label class="custom-control-label" :for="piece.id + 1000"> {{ piece.name }} </label>
      </div>
    </div>
  </div>

  <div style="padding-bottom: 10px">
    <button type="button" class="btn btn-primary" @click="saveWorkoutClick()">Save</button>
  </div>
</template>

<style scoped>
</style>
