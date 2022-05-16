<script setup>
import Exercise1Pic from "/pic1.jpg"
import Exercise2Pic from "/pic2.jpg"
import Exercise3Pic from "/pic3.jpg"

const props = defineProps({
  name: {
    type: String,
    required: true,
  },
  sets: {
    type: Number,
    required: false,
  },
  reps: {
    type: Number,
    required: false,
  },
  duration: {
    type: Number,
    required: false,
  },
  rest: {
    type: Number,
    required: false,
  }
})

console.log("props", props.name)

const getImages = function () {
  let images = [Exercise1Pic, Exercise2Pic, Exercise3Pic];
  return images[Math.floor(Math.random() * images.length)];
}
</script>

<template>
  <div>
    <!-- TODO fix the card layout as object are not where they are supposed to be -->
    <div class="card mb-3">
      <div class="row g-0">
        <div class="col-md-4">
          <h3 class="card-title">{{ props.name }}</h3>
          <img v-bind:src="getImages(picture)" v-bind:alt="name" class="img-fluid rounded-start smallpics" />
          <div class="d-flex float-end">
            <i class="bi bi-trash bi-2x" style="font-size: 35px; padding-right: 10px"></i>
            <i class="bi bi-three-dots-vertical" style="font-size: 35px; padding-right: 10px"></i>
          </div>
        </div>
        <div class="col-md-8">
          <div class="card-body">
            <div class="input-group input-group-sm mb-3">
              <span class="input-group-text" id="setsText">Sets</span>
              <!-- Fix all of the input boxes as they shouldn't be this long, and should be able to stack on eachother instead of individual rows -->
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
