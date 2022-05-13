<script setup>
import Exercise1Pic from "/pic1.jpg";
import Exercise2Pic from "/pic2.jpg";
import Exercise3Pic from "/pic3.jpg";

const props = defineProps({
  name: {
    type: String,
    required: true,
  },
  sets: {
    type: Number,
    required: true,
  },
  reps: {
    type: Number,
    required: true,
  },
  duration: {
    type: Number,
    required: true,
  },
  rest: {
    type: Number,
    required: true,
  }
});

// TODO this info is not being passed properly or at all
console.log("props", props.name)

const getImages = function () {
  let images = [Exercise1Pic, Exercise2Pic, Exercise3Pic];
  return images[Math.floor(Math.random() * images.length)];
};

const cardClick = function (cardName) {
  console.log(cardName);
  // TODO go to the workout editor screen
};
</script>

<template>
  <div>
    <div class="card mb-3" style="max-width: 540px">
      <div class="row g-0">
        <div class="col-md-4">
          <img v-bind:src="getImages(picture)" v-bind:alt="name" class="img-fluid rounded-start smallpics" />
          <h5 class="card-title">{{ props.name }}</h5>
          <i class="bi bi-trash"></i>
          <i class="bi bi-three-dots-vertical"></i>
        </div>
        <div class="col-md-8">
          <div class="card-body">
            <div class="input-group input-group-sm mb-3">
              <span class="input-group-text" id="setsText">Sets</span>
              <input type="number" :value="props.sets" class="form-control" aria-label="Number of sets to complete for this exercise: {{ name }}" aria-describedby="setsText" />
            </div>
            <div v-if="reps != 0" class="input-group input-group-sm mb-3">
              <span class="input-group-text" id="repsText">Reps</span>
              <input type="number" :value="props.reps" class="form-control" aria-label="Number of reps to complete each set for this exercise: {{ name }}" aria-describedby="repsText" />
            </div>
            <div v-if="duration != 0" class="input-group input-group-sm mb-3">
              <span class="input-group-text" id="durationText">Duration</span>
              <input type="number" :value="props.duration" class="form-control" aria-label="How long to complete each set for this exercise: {{ name }}" aria-describedby="durationText" />
            </div>
            <div class="input-group input-group-sm mb-3">
              <span class="input-group-text" id="restText">Rest</span>
              <input type="number" :value="props.rest" class="form-control" aria-label="Number of time to rest for this exercise: {{ name }}" aria-describedby="restText" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.smallpics {
  width: 150px;
}

.g-0 {
  --bs-gutter-: 0,
  display: flex,
  flex-wrap: wrap
}
</style>
