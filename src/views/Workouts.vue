<script setup>
import cardView from '../components/CardView.vue'
import { ApolloClient, InMemoryCache, gql } from "@apollo/client/core";
import { persistCache, LocalStorageWrapper } from 'apollo3-cache-persist';
import  { ref } from "vue"

// Setup apollo client:
const cache = new InMemoryCache()
let forceNetworkJQL = false

persistCache({
  cache,
  storage: new LocalStorageWrapper(window.localStorage)
})

const client = new ApolloClient({
  uri: "https://5ipdns9qfj.execute-api.us-east-1.amazonaws.com/dev/",
  cache: cache,
  // headers: {
  //   "x-api-key": "da2-t4ee7yn64raenc4ntec4vusvpi",
  // },
});

let getWorkouts = gql`
  query Query {
    workouts {
      id
      name
      picture
      description
      user {
        id
      }
      duration
      difficulty
      equipment {
        id
        name
        icon
      }
    }
  }
` 

const workouts = ref([])

client.query({
  query: getWorkouts,
  fetchPolicy: forceNetworkJQL ? 'network-only' : 'cache-first'
})
.then(result => {
  console.log("results", result)
  workouts.value = structuredClone(result.data.workouts)
  console.log("workouts", workouts)
})


// const workouts = {
//   1: {
//     id: 1,
//     name: 'Workout 1',
//     picture: 'TODO Something',
//     description: 'A new workout',
//     user: 'default',
//     duration: 1800,
//     difficulty: 1,
//     equipment: ['barbell', 'dip machine']
//   },
//   2: {
//     id: 2,
//     name: 'Workout B',
//     picture: 'TODO Something',
//     description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam varius tempor justo, ac cursus urna rhoncus id. Etiam id hendrerit metus, et eleifend libero. Phasellus volutpat, erat sed dignissim dignissim, tellus metus elementum mi, vitae vulputate ipsum orci a felis. Phasellus justo justo, tincidunt ac nibh suscipit, iaculis luctus nisi. Suspendisse fringilla dictum viverra. Nullam a pulvinar nisl. Fusce mattis, diam et pretium semper, ante lacus convallis diam, iaculis scelerisque massa tellus a dui. Aliquam eu leo sed metus vehicula finibus. Nam finibus, neque eget congue fringilla, turpis nisl lacinia arcu, eu porttitor tortor tellus sit amet eros. Etiam risus orci, suscipit a justo nec, suscipit placerat est. Nam imperdiet placerat aliquam.',
//     user: 'default',
//     duration: 300,
//     difficulty: 2,
//     equipment: ['barbell', 'dumbell']
//   },
//   3: {
//     id: 3,
//     name: 'Workout 3C',
//     picture: 'TODO Something',
//     description: 'A crazy workout',
//     user: 'default',
//     duration: 1200,
//     difficulty: 1,
//     equipment: ['barbell']
//   },
//   4: {
//     id: 4,
//     name: 'Workout 5',
//     picture: 'TODO Something',
//     description: 'IDK',
//     user: 'default',
//     duration: 700,
//     difficulty: 3,
//     equipment: ['barbell', 'dumbell', 'dip machine']
//   },
//   5:{
//     id: 4,
//     name: 'Workout 5',
//     picture: 'TODO Something',
//     description: 'IDK',
//     user: 'default',
//     duration: 700,
//     difficulty: 3,
//     equipment: ['barbell', 'dumbell', 'dip machine']
//   },
//   6:{
//     id: 4,
//     name: 'Workout 5',
//     picture: 'TODO Something',
//     description: 'IDK',
//     user: 'default',
//     duration: 700,
//     difficulty: 3,
//     equipment: ['barbell', 'dumbell', 'dip machine']
//   },
//   7:{
//     id: 4,
//     name: 'Workout 5',
//     picture: 'TODO Something',
//     description: 'IDK',
//     user: 'default',
//     duration: 700,
//     difficulty: 3,
//     equipment: ['barbell', 'dumbell', 'dip machine']
//   }
// }
</script>

<template>
  <form class="d-flex">
    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" />
    <button class="btn btn-outline-primary" type="submit">Search</button>
  </form>
  <!-- height: calc(100% vertical height - Nav bar (56px) - Search bar (38px) - New workout btn (38px) - IDK-DIK (16px) - Card margin (0.5rem) - Toolbar margin (0.5rem) -->
  <div style="position: relative; height: calc(100vh - 56px - 38px - 38px - 16px - 0.5rem - 0.5rem); margin-top: 0.5rem; overflow: auto">
    <div v-for="workout in workouts" :key="workout" class="card-view">
      <card-view :name="workout.name" :picture="workout.picture" :description="workout.description"></card-view>
    </div>
  </div>
  <button type="button" class="btn btn-outline-secondary mt-2">New Workout</button>
</template>

<style scoped>
p {
  color: black!; /* Figure out how to fix app.vue overriding this */
}
div.card-view:last-child div.card {
  margin-bottom: 0 !important;
}
</style>
