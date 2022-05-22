const { connectSQLDB, querySQLDB } = require('../db/db.js')

// Resolvers define the technique for fetching the types defined in the
// schema. This resolver retrieves books from the "books" array above.
const resolvers = {
  Query: {
    users: () => querySQLDB("SELECT * FROM users").then(result => result),
    workouts: (parent, args) => {
      if (args.id == undefined) args.id = null
      return querySQLDB("SELECT * FROM workout WHERE id like IFNULL(?, '%')", [args.id]).then(result => result)
    },
    equipment: () => querySQLDB("SELECT * FROM equipment").then(result => result),
    musclegroups: () => querySQLDB("SELECT * FROM musclegroup").then(result => result),
    exercises: (parent, args) => {
      if (args.id == undefined) args.id = null
      return querySQLDB("SELECT * FROM exercise WHERE id like IFNULL(?, '%')", [args.id]).then(result => result)
    },
    workoutlogs: () => querySQLDB("SELECT * FROM workoutlog").then(result => result),
    workoutlogexercises: () => querySQLDB("SELECT * FROM workoutlogexercise").then(result => result),
  },
  Workout: {
    user(parent) {
      return querySQLDB("SELECT * FROM users WHERE id = ?", [parent.user]).then(result => result[0])
    },
    equipment(parent) {
      return querySQLDB(`SELECT DISTINCT eq.*
        FROM equipment AS eq
          INNER JOIN exercise_equipment AS ee ON eq.id = ee.equipmentid
            INNER JOIN exercise AS ex ON ee.exerciseid = ex.id
            INNER JOIN workout_exercise AS we ON ex.id = we.exerciseid
            INNER JOIN workout AS w on we.workoutid = w.id
        WHERE w.id=?`, [parent.id])
    },
    exercises(parent) {
      return querySQLDB(`SELECT
          exercise.id,
            exercise.name,
            exercise.video,
            exercise.picture,
            exercise.instructions,
            exercise.difficulty,
            workout_exercise.reps,
            workout_exercise.sets,
            workout_exercise.duration,
            workout_exercise.rest
        FROM exercise
          INNER JOIN workout_exercise ON exercise.id = workout_exercise.exerciseid
          INNER JOIN workout ON workout_exercise.workoutid = workout.id
        WHERE workout.id = ?`, [parent.id])
    },
    // TODO add in duration
    difficulty(parent) {
      return querySQLDB(`SELECT exercise.difficulty AS difficulty
        FROM exercise
          INNER JOIN workout_exercise ON exercise.id = workout_exercise.exerciseid
            INNER JOIN workout ON workout_exercise.workoutid = workout.id
        WHERE workout.id = ?
        GROUP BY exercise.difficulty
        ORDER BY count(exercise.difficulty) DESC
        LIMIT 1`, [parent.id]).then(result => result[0].difficulty)
    }
  },
  Exercise: { // TODO fix the rest of them to match these examples
    musclegroups(parent) {
      return querySQLDB(`SELECT DISTINCT musclegroup.*
        FROM musclegroup
          INNER JOIN exercise_musclegroup ON musclegroup.id = exercise_musclegroup.musclegroupid
            INNER JOIN exercise ON exercise_musclegroup.exerciseid = exercise.id
        WHERE exercise.id = ?`, [parent.id])
    },
    equipment(parent) {
      return querySQLDB(`SELECT DISTINCT equipment.*
        FROM equipment
          INNER JOIN exercise_equipment ON equipment.id = exercise_equipment.equipmentid
            INNER JOIN exercise ON exercise_equipment.exerciseid = exercise.id
        WHERE exercise.id = ?`, [parent.id])
    }
  },
  WorkoutLog: {
    user(parent) {
      return querySQLDB("SELECT * FROM users WHERE id = ?", [parent.user]).then(result => result[0])
    },
    workout(parent) {
      return querySQLDB("SELECT * FROM workout WHERE id = ?", [parent.workout]).then(result => result[0])
    },
    wlexercises(parent) {
      let returnObj = []
      if (parent.workoutlogexercise != null) {
        parent.workoutlogexercise.forEach(element => {
          returnObj.push(querySQLDB("SELECT * FROM workoutlogexercise WHERE id = ?", [element]).then(result => result[0]))
        })
      }
      return returnObj
    }
  },
  WorkoutLogExercise: {
    workoutlog(parent) {
      return querySQLDB("SELECT * FROM workoutlog WHERE id = ?", [parent.workoutlog]).then(result => result[0])
    },
    exercise(parent) {
      return querySQLDB("SELECT * FROM exercise WHERE id = ?", [parent.exercise]).then(result => result[0])
    }
  },
  Mutation: {
    setupdb: () => {
      require('../db/setupdb.js')
      return querySQLDB("SELECT * FROM users").then(result => result)
    },
    addUser: (parent, { name = null, email = null, avatar = null }) => {
      return querySQLDB("INSERT into users (name, email, avatar) VALUES (?, ?, ?)", [name, email, avatar]).then(
        result => querySQLDB("SELECT * FROM users WHERE id = ?", [result.insertId]).then(result => result[0])
      )
    },
    addEquipment: (parent, { name = null, icon = null }) => {
      return querySQLDB("INSERT into equipment (name, icon) VALUES (?, ?)", [name, icon]).then(
        result => querySQLDB("SELECT * FROM equipment WHERE id = ?", [result.insertId]).then(result => result[0])
      )
    },
    addMuscleGroup: (parent, { name = null, picture = null }) => {
      return querySQLDB("INSERT into musclegroup (name, picture) VALUES (?, ?)", [name, picture]).then(
        result => querySQLDB("SELECT * FROM musclegroup WHERE id = ?", [result.insertId]).then(result => result[0])
      )
    },
    addWorkout: (parent, { name = null, picture = null, description = null, user = null, exercises = [] }) => {
      let workoutid = null
      return querySQLDB("INSERT into workout (name, picture, description, user) VALUES (?, ?, ?, ?)", [name, picture, description, user])
        .then(function (result) {
          workoutid = result.insertId
          let inserts = []
          exercises.forEach(element => {
            // TODO umm maybe we should like add this to the insert array??
            querySQLDB("INSERT into workout_exercise (workoutid, exerciseid, reps, sets, duration, rest) VALUES (?, ?, ?, ?, ?, ?)", [workoutid, element.id, element.reps, element.sets, element.duration, element.rest])
          })
          // return promise all
          return Promise.all(inserts)
        })
        .then(function () {
          return querySQLDB("SELECT * FROM workout WHERE id = ?", [workoutid]).then(result => result[0])
        })
    },
    updateWorkout: (parent, { id = null, name = null, picture = null, description = null, user = null, exercises = [] }) => {
      console.log("starting update function")
      let workoutid = id
      return querySQLDB("UPDATE workout SET name = ?, picture = ?, description = ?, user = ? WHERE ID = ?", [name, picture, description, user, id])
        .then(function () {
          console.log("workout id is: ", workoutid)
          // delete all element containing workout id
          return querySQLDB("DELETE from workout_exercise WHERE workoutid = ?", [workoutid])
        })
        .then(function () {
          // then re-add the new ones
          let inserts = []
          exercises.forEach(element => {
            // TODO umm maybe we should like add this to the insert array??
            querySQLDB("INSERT into workout_exercise (workoutid, exerciseid, reps, sets, duration, rest) VALUES (?, ?, ?, ?, ?, ?)", [workoutid, element.id, element.reps, element.sets, element.duration, element.rest])
          })
          // return promise all
          return Promise.all(inserts)
        })
        .then(function () {
          console.log("before return data")
          return querySQLDB("SELECT * FROM workout WHERE id = ?", [workoutid]).then(result => result[0])
        })

    }
    // TODO need to make the rest of the adds and then all of the updates
  }
}

exports.resolvers = resolvers
