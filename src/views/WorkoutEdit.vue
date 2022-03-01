<script setup>
import workoutEditExerciseEdit from '../components/WorkoutEditExerciseEdit.vue'

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

// Has extra fields that about be saved in the workout, not exercise
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
    duration: 0,
    equipment: ['anti-grav machine'],
    sets: 5,
    rest: 30
  },
  2: {
    id: 2,
    name: 'Exercise B',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'Chinups on a bench',
    difficulty: 3,
    muscleGroup: ['chest', 'gravity manipulation'],
    reps: 0,
    duration: 90,
    equipment: ['bench'],
    sets: 4,
    rest: 60
  },
  3: {
    id: 3,
    name: 'Exercise 3C',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'walk in circles',
    difficulty: 0,
    muscleGroup: ['chest', 'gravity manipulation'],
    reps: 0,
    duration: 5,
    equipment: ['ground'],
    sets: 3,
    rest: 90
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
    duration: 0,
    equipment: [],
    sets: 2,
    rest: 120
  }
}
</script>

<template>
  <div class="input-group input-group-lg">
    <span class="input-group-text" id="workoutNameLabel">Workout Name</span>
    <input type="text" class="form-control" id="workoutName" :value="workout.name" aria-label="Workout Name" aria-describedby="workoutNameLabel" />
  </div>
  <img src="/pic1.jpg" alt="pic1" />

  <div class="row align-items-start">
    <div class="col">
      <button type="button" class="btn btn-outline-primary">Upload Photo</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-warning">Remove Photo</button>
    </div>
  </div>

  <h4>Description</h4>
  <input type="text" class="form-control" id="workoutDescription" :value="workout.description" aria-label="Workout Description" />

  <div v-for="exercise in exercises" :key="exercise">
    <workout-edit-exercise-edit :name="exercise.name" :sets="exercise.sets" :reps="exercise.reps" :duration="exercise.duration" :rest="exercise.rest"></workout-edit-exercise-edit>
  </div>

  <div class="row">
    <div class="col">
      <button type="button" class="btn btn-outline-secondary">Add Exercise</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-primary">Save</button>
    </div>
  </div>
</template>

<style scoped>
</style>
