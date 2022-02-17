<template id="workouts">
  <div>
    <div v-for="workout in workouts" :key="workout">
      <workout-card :name="workout.name" :picture="workout.picture" :description="workout.description"></workout-card>
    </div>
  </div>
</template>

<script>
// TODO can we put an ID or something on the workout card to get rid of the duplicate keys detected message
import WorkoutCard from './WorkoutCard.vue'

export default {
  name: 'Workouts',
  components: { WorkoutCard },
  props: {},
  data: function() {
    return {
      workouts: {
        1: {
          id: 1,
          name: 'Workout 1',
          picture: './src/assets/190830-better-workout-dumbbells-se-634p.jpg',
          description: 'A new workout',
          user: 'default',
          duration: 1800,
          difficulty: 1,
          equipment: ['barbell', 'dip machine']
        },
        2: {
          id: 2,
          name: 'Workout B',
          picture: '@/src/assets/istockphoto-1254996126-612x612.jpg',
          description: 'An old workout',
          user: 'default',
          duration: 300,
          difficulty: 2,
          equipment: ['barbell', 'dumbell']
        },
        3: {
          id: 3,
          name: 'Workout 3C',
          picture: '../assets/photo-1571019613454-1cb2f99b2d8b.jfif',
          description: 'A crazy workout',
          user: 'default',
          duration: 1200,
          difficulty: 1,
          equipment: ['barbell']
        },
        4: {
          id: 4,
          name: 'Workout 5',
          picture: 'require(@/src/assets/logo.png)',
          description: 'IDK',
          user: 'default',
          duration: 700,
          difficulty: 3,
          equipment: ['barbell', 'dumbell', 'dip machine']
        }
      }
    }
  }
}
</script>

<style scoped>
</style>
