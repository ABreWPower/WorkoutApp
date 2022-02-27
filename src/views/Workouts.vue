<script setup>
import WorkoutCard from '../components/WorkoutCard.vue'

const workouts = {
  1: {
    id: 1,
    name: 'Workout 1',
    picture: 'TODO Something',
    description: 'A new workout',
    user: 'default',
    duration: 1800,
    difficulty: 1,
    equipment: ['barbell', 'dip machine']
  },
  2: {
    id: 2,
    name: 'Workout B',
    picture: 'TODO Something',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam varius tempor justo, ac cursus urna rhoncus id. Etiam id hendrerit metus, et eleifend libero. Phasellus volutpat, erat sed dignissim dignissim, tellus metus elementum mi, vitae vulputate ipsum orci a felis. Phasellus justo justo, tincidunt ac nibh suscipit, iaculis luctus nisi. Suspendisse fringilla dictum viverra. Nullam a pulvinar nisl. Fusce mattis, diam et pretium semper, ante lacus convallis diam, iaculis scelerisque massa tellus a dui. Aliquam eu leo sed metus vehicula finibus. Nam finibus, neque eget congue fringilla, turpis nisl lacinia arcu, eu porttitor tortor tellus sit amet eros. Etiam risus orci, suscipit a justo nec, suscipit placerat est. Nam imperdiet placerat aliquam.',
    user: 'default',
    duration: 300,
    difficulty: 2,
    equipment: ['barbell', 'dumbell']
  },
  3: {
    id: 3,
    name: 'Workout 3C',
    picture: 'TODO Something',
    description: 'A crazy workout',
    user: 'default',
    duration: 1200,
    difficulty: 1,
    equipment: ['barbell']
  },
  4: {
    id: 4,
    name: 'Workout 5',
    picture: 'TODO Something',
    description: 'IDK',
    user: 'default',
    duration: 700,
    difficulty: 3,
    equipment: ['barbell', 'dumbell', 'dip machine']
  }
}
</script>

<template>
  <form class="d-flex">
    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" />
    <button class="btn btn-outline-success" type="submit">Search</button>
  </form>
  <div v-for="workout in workouts" :key="workout">
    <workout-card :name="workout.name" :picture="workout.picture" :description="workout.description"></workout-card>
  </div>
  <button type="button" class="btn btn-outline-secondary">New Workout</button>
</template>

<style scoped>
</style>
