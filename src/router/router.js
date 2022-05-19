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
    name: 'Exercise View',
    props: { exerciseid: null },
    component: () => import('../views/ExerciseView.vue')
  },
  {
    path: '/exerciseedit/:exerciseid',
    name: 'Exercise Edit',
    props: { exerciseid: null },
    component: () => import('../views/ExerciseEdit.vue')
  },
  {
    path: '/workoutview/:workoutid',
    name: 'Workout View',
    props: { workoutid: null },
    component: () => import('../views/WorkoutView.vue')
  },
  {
    path: '/workoutedit',
    name: 'Workout Add',
    component: () => import('../views/WorkoutEdit.vue')
  },
  {
    path: '/workoutedit/:workoutid',
    name: 'Workout Edit',
    props: {
      workout: true,
      workoutid: true
    },
    component: () => import('../views/WorkoutEdit.vue')
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router