<script setup>
import exerciseCard from '../components/ExerciseCard.vue'

const workout = {
  id: 1,
  name: 'Workout 1',
  picture: 'TODO Something',
  description: 'A new workout',
  user: 'default',
  duration: 1800,
  difficulty: 1,
  equipment: ['barbell', 'dip machine']
}

const exercises = {
  1: {
    id: 1,
    name: 'Exercise 1',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'Pushups while standing on the celling',
    difficulty: 3,
    muscleGroup: ['chest', 'gravity manipulation'],
    reps: 10,
    duration: null,
    equipment: ['anti-grav machine']
  },
  2: {
    id: 2,
    name: 'Exercise B',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'Chinups on a bench',
    difficulty: 3,
    muscleGroup: ['chest', 'gravity manipulation'],
    reps: 10,
    duration: null,
    equipment: ['bench']
  },
  3: {
    id: 3,
    name: 'Exercise 3C',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'walk in circles',
    difficulty: 0,
    muscleGroup: ['chest', 'gravity manipulation'],
    reps: 10,
    duration: null,
    equipment: ['ground']
  },
  4: {
    id: 4,
    name: 'Exercise 5',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'Crunches on the floor',
    difficulty: 1,
    muscleGroup: ['abs'],
    reps: 15,
    duration: null,
    equipment: []
  }
}
</script>

<template>
  <h1>Workout 1</h1>
  <img src="/pic1.jpg" alt="pic1" />

  <div class="row align-items-start">
    <div class="col">Duration: {{ workout.duration / 60 }} min</div>
    <div class="col">
      <div class="row align-items-start">
        <p>
          Difficulty:
          <span v-for="i in [0, 1, 2]" :key="i">
            <i v-if="i < workout.difficulty" class="bi bi-star-fill"></i>
            <i v-else class="bi bi-star"></i>
          </span>
        </p>
      </div>
    </div>
  </div>

  <p>Required Equipment: {{ workout.equipment }}</p>

  <h4>Description</h4>
  <p>
    {{ workout.description }}
  </p>

  <div v-for="exercise in exercises" :key="exercise">
    <exercise-card :name="exercise.name" :picture="exercise.picture" :video="exercise.video" :instructions="exercise.instructions"></exercise-card>
  </div>

  <div class="row">
    <div class="col">
      <button type="button" class="btn btn-primary">Start</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-secondary">Edit</button>
    </div>
  </div>
</template>

<style scoped>
</style>
