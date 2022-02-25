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
</script>

<template>
  <h1>Workout 1</h1>
  <img src="pic1.jpg" alt="pic1" />

  <div class="row align-items-start">
    <div class="col">Duration: {{ workout.duration / 60 }} min</div>
    <div class="col">
      <div class="row align-items-start">
        <p>Difficulty:</p>
        <p v-if="workout.difficulty == 0">
          <img src="icons/star.svg" alt="star" />
          <img src="icons/star.svg" alt="star" />
          <img src="icons/star.svg" alt="star" />
        </p>
        <p v-if="workout.difficulty == 1">
          <img src="icons/star-fill.svg" alt="star" />
          <img src="icons/star.svg" alt="star" />
          <img src="icons/star.svg" alt="star" />
        </p>
        <p v-if="workout.difficulty == 2">
          <img src="icons/star-fill.svg" alt="star" />
          <img src="icons/star-fill.svg" alt="star" />
          <img src="icons/star.svg" alt="star" />
        </p>
        <p v-if="workout.difficulty == 3">
          <img src="icons/star-fill.svg" alt="star" />
          <img src="icons/star-fill.svg" alt="star" />
          <img src="icons/star-fill.svg" alt="star" />
        </p>
      </div>
    </div>
  </div>

  <p>Required Equipment: {{ equipment }}</p>

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
