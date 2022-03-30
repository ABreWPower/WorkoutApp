import { createRouter, createWebHistory } from 'vue-router'

// import NavBar from './views/NavBar.vue'
import Workouts from '../views/Workouts.vue'
// DONE // import Exercises from './views/Exercises.vue'
// import Settings from './views/Settings.vue'
// import About from './views/About.vue'
// import Profile from './views/Profile.vue'

// DONE // import WorkoutPage from './views/WorkoutPage.vue'
// DONE // import WorkoutEdit from './views/WorkoutEdit.vue'

const routes = [
  {
    path: '/',
    name: 'Workouts',
    meta: { navigatable: true },
    component: Workouts
  },
  {
    path: '/exercises',
    name: 'Exercises',
    meta: { navigatable: true },
    component: () => import('../views/Exercises.vue')
  },
  {
    path: '/workoutview',
    name: 'Workout View',
    meta: { navigatable: false }, // TODO make sure that this doesn't show up on the drop down menu
    props: { workoutid: null },
    component: () => import('../views/WorkoutView.vue')
  },
  {
    path: '/workoutedit',
    name: 'Workout Edit',
    meta: { navigatable: false }, // TODO make sure that this doesn't show up on the drop down menu
    props: { workoutid: null },
    component: () => import('../views/WorkoutEdit.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router