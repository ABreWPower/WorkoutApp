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
  {
    path: '/exerciseview',
    name: 'Exercise View',
    props: { exerciseid: null },
    component: () => import('../views/ExerciseView.vue')
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router