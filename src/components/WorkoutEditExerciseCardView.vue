<script setup>
import Exercise1Pic from "/pic1.jpg"
import Exercise2Pic from "/pic2.jpg"
import Exercise3Pic from "/pic3.jpg"

const props = defineProps({
  name: {
    type: String,
    required: true,
  },
  picture: {
    type: String,
    required: false,
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
  },
  weight: {
    type: Number,
    required: false,
  },
  startWorkout:
  {
    type: Boolean,
    required: false,
    default: false,
  },
})

defineEmits(['update:sets', 'update:reps', 'update:duration', 'update:rest'])

console.log("props", props.name)

const getImages = function () {
  let images = [Exercise1Pic, Exercise2Pic, Exercise3Pic];
  return images[Math.floor(Math.random() * images.length)];
}
</script>


<template>
  <div>
    <div class="card mb-3">
      <div class="row g-0">
        <div class="col-fluid-4">
          <h3 class="card-title">{{ props.name }}</h3>
          <!-- <img v-bind:src="getImages(picture)" v-bind:alt="name" class="img-fluid rounded-start smallpics" /> -->
          <img v-if="picture != null" :src="`/${picture}`" v-bind:alt="name" class="img-fluid rounded-start smallpics" />
          <img v-else :src="getImages()" v-bind:alt="name" class="img-fluid rounded-start smallpics" />
          <div class="d-flex float-end">
            <i v-if="startWorkout == false" class="bi bi-trash bi-2x" style="font-size: 35px; padding-right: 10px" @click="$emit('delete')"></i>
            <i v-if="startWorkout == false" class="bi bi-three-dots-vertical" style="font-size: 35px; padding-right: 10px"></i>
            <i v-if="startWorkout == false" class="bi bi-caret-down-fill" style="font-size: 35px; padding-right: 10px" @click="$emit('move:down')"></i>
            <i v-if="startWorkout == false" class="bi bi-caret-up-fill" style="font-size: 35px; padding-right: 10px" @click="$emit('move:up')"></i>
          </div>
        </div>
        <div class="col-md-8">
          <div class="card-body">
            <div class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto">
              <span class="input-group-text" id="setsText" style="width: 75px">Sets</span>
              <input
                type="number"
                :value="props.sets"
                @input="$emit('update:sets', $event.target.value)"
                class="form-control"
                aria-label="Number of sets to complete for this exercise: {{ name }}"
                aria-describedby="setsText"
                style="max-width: 75px" />
            </div>
            <div v-if="reps != 0" class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto">
              <span class="input-group-text" id="repsText" style="width: 75px">Reps</span>
              <input
                type="number"
                :value="props.reps"
                @input="$emit('update:reps', $event.target.value)"
                class="form-control"
                aria-label="Number of reps to complete each set for this exercise: {{ name }}"
                aria-describedby="repsText"
                style="max-width: 75px" />
            </div>
            <div v-if="duration != 0" class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto">
              <span class="input-group-text" id="durationText" style="width: 75px">Duration</span>
              <input
                type="number"
                :value="props.duration"
                @input="$emit('update:duration', $event.target.value)"
                class="form-control"
                aria-label="How long to complete each set for this exercise: {{ name }}"
                placeholder="Seconds"
                aria-describedby="durationText"
                style="max-width: 75px" />
            </div>
            <div class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto">
              <span class="input-group-text" id="restText" style="width: 75px">Rest</span>
              <input
                type="number"
                :value="props.rest"
                @input="$emit('update:rest', $event.target.value)"
                class="form-control"
                aria-label="Number of time to rest for this exercise: {{ name }}"
                placeholder="Seconds"
                aria-describedby="restText"
                style="max-width: 75px" />
            </div>
            <div v-if="startWorkout == true" class="input-group input-group-sm m-1 d-inline-flex align-items-center w-auto">
              <span class="input-group-text" id="weightText" style="width: 75px">Weight</span>
              <input
                type="number"
                :value="props.weight"
                @input="$emit('update:weight', $event.target.value)"
                class="form-control"
                aria-label="Number of weight for this exercise: {{ name }}"
                placeholder="Pounds"
                aria-describedby="weightText"
                style="max-width: 75px" />
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
