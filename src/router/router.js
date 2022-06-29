import { createRouter, createWebHistory } from 'vue-router'

import Workouts from '../views/Workouts.vue'


const routes = [
  {
    path: '/',
    name: 'Workouts',
    component: Workouts
  },
  {
    path: '/exercises',
    name: 'Exercises',
    component: () => import('../views/Exercises.vue')
  },
  {
    path: '/exerciseview/:exerciseid',
    name: 'View Exercise',
    props: { exerciseid: null },
    component: () => import('../views/ViewExercise.vue')
  },
  {
    path: '/exerciseedit',
    name: 'Add Exercise',
    component: () => import('../views/EditExercise.vue')
  },
  {
    path: '/exerciseedit/:exerciseid',
    name: 'Edit Exercise',
    props: {
      exercise: null,
      exerciseid: null
    },
    component: () => import('../views/EditExercise.vue')
  },
  {
    path: '/viewworkout/:workoutid',
    name: 'View Workout',
    props: { workoutid: null },
    component: () => import('../views/ViewWorkout.vue')
  },
  {
    path: '/editworkout',
    name: 'Add Workout',
    component: () => import('../views/EditWorkout.vue')
  },
  {
    path: '/editworkout/:workoutid',
    name: 'Edit Workout',
    props: {
      workout: true,
      workoutid: true
    },
    component: () => import('../views/EditWorkout.vue')
  },
  {
    path: '/startworkout/:workoutid',
    name: 'Start Workout',
    props: {
      workout: true,
      workoutid: true
    },
    component: () => import('../views/StartWorkout.vue')
  },
  {
    path: '/activeworkout/:workoutlogid',
    name: 'Active Workout',
    props: {
      workoutlogid: true
    },
    component: () => import('../views/ActiveWorkout.vue')
    // TODO add props for new log data type
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router