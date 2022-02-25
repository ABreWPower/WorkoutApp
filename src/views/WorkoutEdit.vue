<script setup>
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
    duration: null,
    equipment: ['anti-grav machine']
  },
  2: {
    id: 2,
    name: 'Exercise B',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'Chinups on a bench',
    difficulty: 3,
    muscleGroup: ['chest', 'gravity manipulation'],
    reps: 10,
    duration: null,
    equipment: ['bench']
  },
  3: {
    id: 3,
    name: 'Exercise 3C',
    picture: 'TODO Something',
    video: 'TODO Something',
    instructions: 'walk in circles',
    difficulty: 0,
    muscleGroup: ['chest', 'gravity manipulation'],
    reps: 10,
    duration: null,
    equipment: ['ground']
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
    duration: null,
    equipment: []
  }
}
</script>

<template>
  <div class="input-group input-group-lg">
    <span class="input-group-text" id="workoutNameLabel">Workout Name</span>
    <input
      type="text"
      class="form-control"
      id="workoutName"
      :value="workout.name"
      aria-label="Workout Name"
      aria-describedby="workoutNameLabel"
    />
  </div>
  <img src="pic1.jpg" alt="pic1" />

  <div class="row align-items-start">
    <div class="col">
      <button type="button" class="btn btn-outline-primary">
        Upload Photo
      </button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-warning">
        Remove Photo
      </button>
    </div>
  </div>

  <h4>Description</h4>
  <p>
    Nullam commodo auctor sem, id pellentesque urna ultrices eleifend. Sed risus
    enim, fermentum ac metus in, auctor gravida felis.
  </p>

  <div class="card mb-3" style="max-width: 540px">
    <div class="row g-0">
      <div class="col-md-4">
        <img src="pic2.jpg" class="img-fluid rounded-start" alt="..." />
      </div>
      <div class="col-md-8">
        <div class="card-body">
          <h5 class="card-title">Exercise 1</h5>
          <p class="card-text">
            Description: Lorem ipsum dolor sitamet, consectetur adipiscing elit.
            In a odio odio.
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="card mb-3" style="max-width: 540px">
    <div class="row g-0">
      <div class="col-md-4">
        <img src="pic3.jpg" class="img-fluid rounded-start" alt="..." />
      </div>
      <div class="col-md-8">
        <div class="card-body">
          <h5 class="card-title">Exercise 2</h5>
          <p class="card-text">
            Description: Lorem ipsum dolor sitamet, consectetur adipiscing elit.
            In a odio odio.
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="card mb-3" style="max-width: 540px">
    <div class="row g-0">
      <div class="col-md-4">
        <img src="pic2.jpg" class="img-fluid rounded-start" alt="..." />
      </div>
      <div class="col-md-8">
        <div class="card-body">
          <h5 class="card-title">Exercise 3</h5>
          <p class="card-text">
            Description: Lorem ipsum dolor sitamet, consectetur adipiscing elit.
            In a odio odio.
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col">
      <button type="button" class="btn btn-primary">Start</button>
    </div>
    <div class="col">
      <button type="button" class="btn btn-outline-secondary">Edit</button>
    </div>
  </div>
</template>

<style scoped>
</style>
