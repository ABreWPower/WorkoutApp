<template id="workoutcard">
  <div>
    <v-ons-card @click="cardClick(name)">
      <v-ons-row>
        <v-ons-col width="33%">
          <img v-bind:src="getImages(picture)" v-bind:alt="name"></img>
        </v-ons-col>
        <v-ons-col style="width: 66%">
          <div class="title">{{ name }}</div>
          <div class="content">
            <p>{{ description }}</p>
          </div>
        </v-ons-col>
      </v-ons-row>
    </v-ons-card>
  </div>
</template>

<script>
import Workout1Pic from '../assets/workout1.png'
import Workout2Pic from '../assets/workout2.png'
import Workout3Pic from '../assets/workout3.png'

export default {
  name: 'WorkoutCard',
  props: {
    name: String,
    picture: String,
    description: String
  },
  methods: {
    getImages: function(pic) {
      // TODO need to figure out how to get images loaded, browser don't have access to requires, maybe use webpack
      // var images = requires.context('../assets/', false, /\.jpeg$/)
      // return images('./' + pic)
      let images = [Workout1Pic, Workout2Pic, Workout3Pic]
      return images[Math.floor(Math.random() * images.length)]
    },
    cardClick: function(cardName) {
      console.log(cardName)
      // TODO go to the workout editor screen
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
img {
  max-width: 100%;
}
</style>
