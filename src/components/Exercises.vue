<script setup>
import WorkoutCard from './ExerciseCard.vue'

const exercises = {
  1: {
    id: 1,
    name: 'Exercise 1',
    picture: 'TODO Something',
    description: 'Pushups'
  },
  2: {
    id: 2,
    name: 'Exercise B',
    picture: 'TODO Something',
    description: 'Chinups'
  },
  3: {
    id: 3,
    name: 'Exercise 3C',
    picture: 'TODO Something',
    description: 'burpees'
  },
  4: {
    id: 4,
    name: 'Exercise 5',
    picture: 'TODO Something',
    description: 'IDK'
  }
}
</script>

<template>
  <form class="d-flex">
    <input
      class="form-control me-2"
      type="search"
      placeholder="Search"
      aria-label="Search"
    />
    <button class="btn btn-outline-success" type="submit">Search</button>
  </form>
  <div v-for="exercise in exercises" :key="exercise">
    <workout-card
      :name="exercise.name"
      :picture="exercise.picture"
      :description="exercise.description"
    ></workout-card>
  </div>
  <button type="button" class="btn btn-outline-secondary">New Exercise</button>
</template>

<style scoped>
</style>
