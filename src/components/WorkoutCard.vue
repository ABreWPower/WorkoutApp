<script setup>
import Workout1Pic from "/pic1.jpg";
import Workout2Pic from "/pic2.jpg";
import Workout3Pic from "/pic3.jpg";

defineProps({
  name: {
    type: String,
    required: true,
  },
  picture: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
});

const getImages = function () {
  let images = [Workout1Pic, Workout2Pic, Workout3Pic];
  return images[Math.floor(Math.random() * images.length)];
};

const cardClick = function (cardName) {
  console.log(cardName);
  // TODO go to the workout editor screen
};
</script>

<template>
  <div>
    <div class="card mb-3 mx-3" style="max-width: 540px">
      <div class="row g-0">
        <div class="col-md-4">
          <img
            v-bind:src="getImages(picture)"
            v-bind:alt="name"
            class="img-fluid rounded-start"
          />
        </div>
        <div class="col-md-8">
          <div class="card-body">
            <h5 class="card-title">{{ name }}</h5>
            <p class="card-text">Description: {{ description }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
