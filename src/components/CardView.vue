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
  },
  clickHandler: {
    type: Function,
    required: false,
  }
})

const getImages = function () {
  let images = [Workout1Pic, Workout2Pic, Workout3Pic];
  return images[Math.floor(Math.random() * images.length)];
}

const cardClick = () => {
  console.log("CardView cardClick")
  if(props.clickHandler !== undefined) {
    console.log("CardView cardClick carkHandler found")
    props.clickHandler()
  } else {
    console.log("CardView cardClick cardHandler not found")
    if (props.workoutid != null) {
      console.log("props.workoutid", props.workoutid)
      router.push({ name: 'View Workout', params: { workoutid: props.workoutid } })
      console.log("after router push")
    }
    if (props.exerciseid != null) {
      console.log("props.exerciseid", props.exerciseid)
      router.push({ name: 'View Exercise', params: { exerciseid: props.exerciseid } })
      console.log("after router push")
    }
  }
}
</script>

<template>
  <div class="card mb-3 border-secondary" style="max-height: 8em; cursor: pointer" @click="cardClick">
    <div class="row g-0">
      <!-- TODO put video if there is one otherwise picture -->
      <div class="col-4 align-self-center">
        <img v-if="picture != null" :src="`/${picture}`" v-bind:alt="name" class="img-fluid rounded-start w-100" style="max-height: 8em; max-width: 180px" />
        <img v-else :src="getImages()" v-bind:alt="name" class="img-fluid rounded-start w-100" style="max-height: 8em; max-width: 180px" />
      </div>
      <div class="col-8">
        <div class="card-body">
          <h5 class="card-title">{{ name }}</h5>
          <p v-if="workoutid != null" class="card-text overflow-hidden" style="text-overflow: ellipsis; -webkit-line-clamp: 2; -webkit-box-orient: vertical; display: -webkit-box">Description: {{ description }}</p>
          <p v-if="exerciseid != null" class="card-text overflow-hidden" style="text-overflow: ellipsis; -webkit-line-clamp: 2; -webkit-box-orient: vertical; display: -webkit-box">Instructions: {{ description }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
