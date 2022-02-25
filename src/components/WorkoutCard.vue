<script setup>
// import Workout1Pic from "../assets/pic1.png";
// import Workout2Pic from "pic2.png";
// import Workout3Pic from "pic3.png";

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
  // let images = [Workout1Pic, Workout2Pic, Workout3Pic];
  // return images[Math.floor(Math.random() * images.length)];
};

const cardClick = function (cardName) {
  console.log(cardName);
  // TODO go to the workout editor screen
};
</script>

<template>
  <div>
    I am here
  </div>
</template>

<style scoped>
img {
  max-width: 100%;
}
</style>
