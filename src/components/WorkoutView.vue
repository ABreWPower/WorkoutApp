<template id="workoutview">
  <div>
    <h1>{{ workout.name }}</h1>
    <img v-bind:src="workout.picture" v-bind:alt="workout.name" style="width: 85%" />

    <v-ons-row>
      <v-on-col width="50%">
        <p>Duration: {{ workout.duration }}</p>
      </v-on-col>
      <v-on-col width="50%">
        <p v-if="workout.difficulty == 0">Difficulty:</p>
        <p v-if="workout.difficulty == 1">
          Difficulty:
          <ons-icon icon="star"></ons-icon>
        </p>
        <p v-if="workout.difficulty == 2">
          Difficulty:
          <ons-icon icon="star"></ons-icon>
          <ons-icon icon="star"></ons-icon>
          <ons-icon icon="star-rate"></ons-icon>
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

    <!-- link the exercies card component -->

    <v-ons-row class="center">
      <v-ons-button style="margin: 6px 0">Start</v-ons-button>
      <v-ons-button modifier="outline" style="margin: 6px 0">Edit</v-ons-button>
    </v-ons-row>
  </div>
</template>

<script>
// TODO will need to get the data passed to which workout this is and then pull it from the "database"

export default {
  name: 'WorkoutView',
  components: {},
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
        linkedExercises: ['chinups', 'pullups', 'pushups']
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
</style>
