<template id="workoutview">
  <div>
    <h1>{{ workout.name }}</h1>
    <img v-bind:src="workout.picture" v-bind:alt="workout.name" style="width: 85%" />

    <v-ons-row>
      <v-on-col width="50%">
        <p>Duration: {{ workout.duration }}</p>
      </v-on-col>
      <v-on-col width="50%" class="right">
        <p v-if="workout.difficulty == 0">Difficulty:</p>
        <p v-if="workout.difficulty == 1">
          Difficulty:
          <ons-icon icon="star"></ons-icon>
        </p>
        <p v-if="workout.difficulty == 2">
          Difficulty:
          <ons-icon icon="star"></ons-icon>
          <ons-icon icon="star"></ons-icon>
          <ons-icon icon="fa-star" class="far"></ons-icon>
        </p>
        <p v-if="workout.difficulty == 3">
          Difficulty:
          <ons-icon icon="star"></ons-icon>
          <ons-icon icon="star"></ons-icon>
          <ons-icon icon="star"></ons-icon>
        </p>
      </v-on-col>
    </v-ons-row>

    <p>Required Equipment: {{ workout.equipment }}</p>

    <h5>Description:</h5>
    <p>{{ workout.description }}</p>

    <div v-for="exercise in workout.linkedExercises" :key="exercise">
      <exercise-card :name="exercise.name" :picture="exercise.picture" :description="exercise.description"></exercise-card>
    </div>

    <v-ons-row class="center">
      <v-ons-button style="margin: 6px 0">Start</v-ons-button>
      <v-ons-button modifier="light" style="margin: 6px 0">Edit</v-ons-button>
    </v-ons-row>
  </div>
</template>

<script>
// TODO will need to get the data passed to which workout this is and then pull it from the "database"

import ExerciseCard from './ExerciseCard.vue'

export default {
  name: 'WorkoutView',
  components: { ExerciseCard },
  props: {},
  data: function() {
    return {
      workout: {
        id: 2,
        name: 'Workout B',
        picture: '/src/assets/istockphoto-1254996126-612x612.jpg',
        description: 'An old workout',
        user: 'default',
        duration: 300,
        difficulty: 2,
        equipment: ['barbell', 'dumbell'],
        linkedExercises: {
          1: {
            name: 'chinup',
            description: 'pull your self up',
            picture: '/src/assets/istockphoto-1254996126-612x612.jpg'
          },
          2: {
            name: 'pullup',
            description: 'pull your self up',
            picture: '/src/assets/istockphoto-1254996126-612x612.jpg'
          },
          3: {
            name: 'push',
            description: 'controlled falling',
            picture: '/src/assets/istockphoto-1254996126-612x612.jpg'
          }
        }
      }
    }
  },
  methods: {
    getImages: function(pic) {
      // TODO need to figure out how to get images loaded, browser don't have access to requires, maybe use webpack
      // var images = requires.context('../assets/', false, /\.jpeg$/)
      // return images('./' + pic)
      return null
    }
  }
}
</script>

<style scoped>
p,
h1,
h4,
h5 {
  text-align: left;
}
v-on-col.right {
  margin-left: auto;
}

ons-row.center {
  justify-content: space-evenly;
}
</style>
