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
    exerciseandworkout: () => {
      return querySQLDB(`SELECT
        id,
        'exercise' AS type,
        exercise.name,
        picture,
        instructions
      FROM exercise
      UNION
      SELECT
        id,
        'workout' AS type,
        workout.name,
        picture,
        workout.description
      FROM workout`)
    },
    workoutlogs: (parent, args) => {
      if (args.id == undefined) args.id = null
      return querySQLDB("SELECT * FROM workoutlog WHERE id like IFNULL(?, '%')", [args.id]).then(result => result)
    }
  },
  Workout: {
    user(parent) {
      return querySQLDB("SELECT * FROM users WHERE id = ?", [parent.userid]).then(result => result[0])
    },
    duration_calculated(parent) {
      return querySQLDB(`SELECT sum((ifnull(workout_exercise.duration, workout_exercise.reps * 4) + ifnull(workout_exercise.rest, 5)) * ifnull(workout_exercise.sets, 1)) AS duration_calculated
        FROM workout_exercise
          INNER JOIN workout ON workout.id = workout_exercise.workoutid
        WHERE workout.id = ?`, [parent.id]).then(result => result[0].duration_calculated)
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
      'exercise' as type,
      exercise.name,
      exercise.video,
      exercise.picture,
      exercise.instructions,
      exercise.difficulty,
      workout_exercise.reps,
      ifnull(workout_exercise.sets, 1) AS sets,
      workout_exercise.duration,
      workout_exercise.rest,
      ifnull(workout_exercise.duration, workout_exercise.reps * 4) + ifnull(workout_exercise.rest, 5) AS duration_calculated,
        workout_exercise.sort
    FROM exercise
      INNER JOIN workout_exercise ON exercise.id = workout_exercise.exerciseid
      INNER JOIN workout ON workout_exercise.workoutid = workout.id
    WHERE workout.id = ?
    UNION
    SELECT
      workout.id,
      'workout' as type,
      workout.name,
      null AS video,
      picture,
      workout.description AS instructions,
      null AS difficulty,		-- calulcate??
      null AS reps,
      null AS sets,
      (SELECT sum((ifnull(workout_exercise.duration, workout_exercise.reps * 4) + ifnull(workout_exercise.rest, 5)) * ifnull(workout_exercise.sets, 1)) AS duration_calculated
      FROM workout_exercise
        INNER JOIN workout w1 ON w1.id = workout_exercise.workoutid
      WHERE w1.id = workout.id) AS duration,
      null AS rest,
      null AS duration_calculated,
      workout_workout.sort
    FROM workout
      INNER JOIN workout_workout ON workout_workout.workoutid = workout.id AND workout_workout.super_workoutid = ?
    ORDER BY sort ASC`, [parent.id, parent.id])
    },
    difficulty(parent) {
      return querySQLDB(`SELECT exercise.difficulty AS difficulty
        FROM exercise
          INNER JOIN workout_exercise ON exercise.id = workout_exercise.exerciseid
            INNER JOIN workout ON workout_exercise.workoutid = workout.id
        WHERE workout.id = ?
        GROUP BY exercise.difficulty
        ORDER BY count(exercise.difficulty) DESC
        LIMIT 1`, [parent.id]).then(result => result[0] ? result[0].difficulty : null)
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
    workout(parent) {
      return querySQLDB("SELECT * FROM workout WHERE id = ?", [parent.workoutid]).then(result => result[0])
    },
    user(parent) {
      return querySQLDB("SELECT * FROM users WHERE id = ?", [parent.userid]).then(result => result[0])
    },
    exerciselogs(parent) {
      return querySQLDB("SELECT * FROM workoutlogexercise WHERE workoutlogid = ? ORDER BY workoutlogexercise.sort", [parent.id])
    },
    span(parent) {
      return querySQLDB("SELECT SUM(span) AS span FROM workoutlogexercise WHERE workoutlogid = ?", [parent.id]).then(result => result[0].span)
    },
    actualspan(parent) {
      return querySQLDB("SELECT SUM(actualspan) AS actualspan FROM workoutlogexercise WHERE workoutlogid = ?", [parent.id]).then(result => result[0].actualspan)
    }
  },
  ExerciseLog: {
    workoutlog(parent) {
      return querySQLDB("SELECT * FROM workoutlog WHERE id = ?", [parent.workoutlogid]).then(result => result[0])
    },
    exercise(parent) {
      return querySQLDB("SELECT * FROM exercise WHERE id = ?", [parent.exerciseid]).then(result => result[0])
    }
  },
  Mutation: {
    addUser: (parent, { name = null, email = null, avatar = null }) => {
      return querySQLDB("INSERT into users (name, email, avatar) VALUES (?, ?, ?)", [name, email, avatar]).then(
        result => querySQLDB("SELECT * FROM users WHERE id = ?", [result.insertId]).then(result => result[0])
      )
    },
    addWorkout: (parent, { name = null, picture = null, description = null, user = null, circuit_rounds = null, exercises = [] }) => {
      let workoutid = null
      return querySQLDB("INSERT into workout (name, picture, description, circuit_rounds, userid) VALUES (?, ?, ?, ?, 1)", [name, picture, description, circuit_rounds])
        .then(function (result) {
          workoutid = result.insertId
          let inserts = []
          exercises.forEach(element => {
            ["id", "reps", "sets", "duration", "rest", "sort"].forEach(function (columnName) {
              if (element[columnName] === undefined) {
                element[columnName] = null
              }
            })
            if (element.type == 'exercise') inserts.push(querySQLDB("INSERT into workout_exercise (workoutid, exerciseid, reps, sets, duration, rest, sort) VALUES (?, ?, ?, ?, ?, ?, ?)", [workoutid, element.id, element.reps, element.sets, element.duration, element.rest, element.sort]))
            else inserts.push(querySQLDB("INSERT INTO workout_workout (super_workoutid, workoutid, sort) VALUES (?, ?, ?)", [workoutid, element.id, element.sort]))
          })
          // return promise all
          return Promise.all(inserts)
        })
        .then(function () {
          return querySQLDB("SELECT * FROM workout WHERE id = ?", [workoutid]).then(result => result[0])
        })
    },
    updateWorkout: (parent, { id = null, name = null, picture = null, description = null, user = null, circuit_rounds = null, exercises = [] }) => {
      console.log("starting update function")
      let workoutid = id
      return querySQLDB("UPDATE workout SET name = ?, picture = ?, description = ?, circuit_rounds = ?, userid = 1 WHERE ID = ?", [name, picture, description, circuit_rounds, workoutid])
        .then(function () {
          console.log("workout id is: ", workoutid)
          // delete all element containing workout id
          deletes = []
          deletes.push(querySQLDB("DELETE from workout_exercise WHERE workoutid = ?", [workoutid]))
          deletes.push(querySQLDB("DELETE from workout_workout WHERE super_workoutid = ?", [workoutid]))
          return Promise.all(deletes)
        })
        .then(function () {
          // then re-add the new ones
          let inserts = []
          exercises.forEach(element => {
            ["id", "reps", "sets", "duration", "rest", "sort"].forEach(function (columnName) {
              if (element[columnName] === undefined) {
                element[columnName] = null
              }
            })
            if (element.type == 'exercise') inserts.push(querySQLDB("INSERT into workout_exercise (workoutid, exerciseid, reps, sets, duration, rest, sort) VALUES (?, ?, ?, ?, ?, ?, ?)", [workoutid, element.id, element.reps, element.sets, element.duration, element.rest, element.sort]))
            else inserts.push(querySQLDB("INSERT INTO workout_workout (super_workoutid, workoutid, sort) VALUES (?, ?, ?)", [workoutid, element.id, element.sort]))
          })
          // return promise all
          return Promise.all(inserts)
        })
        .then(function () {
          console.log("before return data")
          return querySQLDB("SELECT * FROM workout WHERE id = ?", [workoutid]).then(result => result[0])
        })
    },
    addExercise: (parent, { name = null, video = null, picture = null, instructions = null, difficulty = null, reps = null, duration = null, musclegroups = [], equipment = [] }) => {
      let exerciseId = null
      if (musclegroups === null) musclegroups = []
      if (equipment === null) equipment = []
      return querySQLDB(`INSERT INTO exercise
        (name, video, picture, instructions, difficulty, reps, duration)
        VALUES (?, ?, ?, ?, ?, ?, ?)`, [name, video, picture, instructions, difficulty, reps, duration])
        .then(function (result) {
          exerciseId = result.insertId
          let inserts = []
          musclegroups.forEach(element => {
            inserts.push(querySQLDB("INSERT into exercise_musclegroup VALUES (?, ?)", [exerciseId, element]))
          })
          equipment.forEach(element => {
            inserts.push(querySQLDB("INSERT into exercise_equipment VALUES (?, ?)", [exerciseId, element]))
          })
          // return promise all
          return Promise.all(inserts)
        })
        .then(function () {
          return querySQLDB("SELECT * FROM exercise WHERE id = ?", [exerciseId]).then(result => result[0])
        })
    },
    updateExercise: (parent, { id = null, name = null, video = null, picture = null, instructions = null, difficulty = null, reps = null, duration = null, musclegroups = [], equipment = [] }) => {
      let exerciseId = id
      if (musclegroups === null) musclegroups = []
      if (equipment === null) equipment = []
      return querySQLDB(`UPDATE exercise SET
          name = ?,
          video = ?,
          picture = ?,
          instructions = ?,
          difficulty = ?,
          reps = ?,
          duration = ?
        WHERE id = ?`, [name, video, picture, instructions, difficulty, reps, duration, exerciseId])
        .then(function () {
          let deletes = []
          deletes.push(querySQLDB("DELETE from exercise_musclegroup WHERE exerciseid = ?", [exerciseId]))
          deletes.push(querySQLDB("DELETE from exercise_equipment WHERE exerciseid = ?", [exerciseId]))
          // return promise all
          return Promise.all(deletes)
        })
        .then(function () {
          let inserts = []
          musclegroups.forEach(element => {
            inserts.push(querySQLDB("INSERT into exercise_musclegroup VALUES (?, ?)", [exerciseId, element]))
          })
          equipment.forEach(element => {
            inserts.push(querySQLDB("INSERT into exercise_equipment VALUES (?, ?)", [exerciseId, element]))
          })
          // return promise all
          return Promise.all(inserts)
        })
        .then(function () {
          return querySQLDB("SELECT * FROM exercise WHERE id = ?", [exerciseId]).then(result => result[0])
        })
    },
    startWorkoutLog: (parent, { workoutid = null, exerciselogs = [] }) => {
      let workoutlogid = null
      return querySQLDB("INSERT into workoutlog (workoutid, userid, datestarted) VALUES (?, 1, NOW())", [workoutid])
        .then(function (result) {
          workoutlogid = result.insertId
          let inserts = []
          exerciselogs.forEach((element, exerciseIndex) => {
            ["exerciseid", "reps", "sets", "duration", "rest", "weight"].forEach(function (columnName) {
              if (element[columnName] === undefined) {
                element[columnName] = null
              }
            })
            if (element.type == 'exercise') {
              inserts.push(querySQLDB("INSERT into workoutlogexercise (workoutlogid, exerciseid, reps, sets, duration, rest, weight, sort) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                [workoutlogid, element.exerciseid, element.reps, element.sets, element.duration, element.rest, element.weight, exerciseIndex]))
            }
            else {
              inserts.push(querySQLDB(`INSERT INTO workoutlogexercise (workoutlogid, exerciseid, sets, reps, duration, rest, weight, sort) 
              SELECT
                ? AS workoutlogid,
                exercise.id AS exerciseid,
                workout_exercise.sets,
                workout_exercise.reps,
                workout_exercise.duration,
                workout_exercise.rest,
                null AS weight,
                CONCAT(?, ".", workout_exercise.sort) AS sort
              FROM exercise
                INNER JOIN workout_exercise ON exercise.id = workout_exercise.exerciseid
              WHERE workout_exercise.workoutid = ?`,
                [workoutlogid, exerciseIndex, element.exerciseid]))
            }
          })
          // return promise all
          return Promise.all(inserts)
        })
        .then(function () {
          return querySQLDB("SELECT * FROM workoutlog WHERE id = ?", [workoutlogid]).then(result => result[0])
        })
    },
    endWorkoutLog: (parent, { id = null }) => {
      return querySQLDB("UPDATE workoutlog SET datecompleted = ifnull(datecompleted, NOW()) WHERE id = ?", [id])
        .then(function () {
          return querySQLDB("SELECT * FROM workoutlog WHERE id = ?", [id]).then(result => result[0])
        })
    },
    startExerciseLog: (parent, { id = null }) => {
      return querySQLDB("UPDATE workoutlogexercise SET datestarted = ifnull(datestarted, NOW()) WHERE id = ?", [id])
        .then(function () {
          return querySQLDB("SELECT * FROM workoutlogexercise WHERE id = ?", [id]).then(result => result[0])
        })
    },
    endExerciseLog: (parent, { span = null, id = null }) => {
      return querySQLDB("UPDATE workoutlogexercise SET span = ifnull(span + ?, ?), datecompleted = ifnull(datecompleted, NOW()) WHERE id = ?", [span, span, id])
        .then(function () {
          return querySQLDB("SELECT * FROM workoutlogexercise WHERE id = ?", [id]).then(result => result[0])
        })
    }
  },
}

exports.resolvers = resolvers
