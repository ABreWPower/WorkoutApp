<script setup>
import router from "../router/router.js"

import Workout1Pic from "/pic1.jpg"
import Workout2Pic from "/pic2.jpg"
import Workout3Pic from "/pic3.jpg"

const props = defineProps({
  name: {
    type: String,
    required: true,
  },
  picture: {
    type: String,
    required: false,
  },  
  video: {
    type: String,
    required: false,
  },
  description: {
    type: String,
    required: true,
  },
  workoutid: {
    type: String,
    required: false,
  },
  exerciseid: {
    type: String,
    required: false,
  }
})

const getImages = function () {
  let images = [Workout1Pic, Workout2Pic, Workout3Pic];
  return images[Math.floor(Math.random() * images.length)];
}

const cardClick = () => {  
  if (props.workoutid != null) {
    console.log("props.workoutid", props.workoutid)
    router.push({ name: 'Workout View', params: { workoutid: props.workoutid } })
    console.log("after router push")
  }
  console.log("props.exerciseid", props.exerciseid)
}
</script>

<template>
  <div class="card mb-3 border-secondary" style="max-height: 8em">
    <div class="row g-0">
      <!-- TODO put video if there is one otherwise picture -->
      <div class="col-4 align-self-center">
        <img v-bind:src="getImages(picture)" v-bind:alt="name" class="img-fluid rounded-start w-100" style="max-height: 8em; max-width: 180px" />
      </div>
      <div class="col-8">
        <div class="card-body">
          <h5 class="card-title">{{ name }}</h5>
          <p class="card-text overflow-hidden" style="text-overflow: ellipsis; -webkit-line-clamp: 2; -webkit-box-orient: vertical; display: -webkit-box">Description: {{ description }}</p>
          <a href="#" class="stretched-link" @click="cardClick"></a>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
