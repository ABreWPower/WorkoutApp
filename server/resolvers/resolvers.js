const { connectSQLDB, querySQLDB } = require('../db/db.js')

// Resolvers define the technique for fetching the types defined in the
// schema. This resolver retrieves books from the "books" array above.
const resolvers = {
  Query: {
    users: () => querySQLDB("SELECT * FROM users").then(result => result),
    // workouts: (parent, args) => {
    //   console.log("parent", parent)
    //   console.log("args", args.id)
    //   querySQLDB("SELECT * FROM workout WHERE id like ?", args.id }).then(result => {
    //     console.log("results", result)
    //     return result
    //   })
    // },
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
      let returnObj = []
      if (parent.equipment != null) {
        parent.equipment.forEach(element => {
          returnObj.push(querySQLDB("SELECT * FROM equipment WHERE id = ?", [element]).then(result => result[0]))
        })
      }
      return returnObj
    },
    exercises(parent) {
      let returnObj = []
      // console.log(parent)
      if (parent.exercises != null) {
        parent.exercises.forEach(element => {
          returnObj.push(querySQLDB("SELECT * FROM exercise WHERE id = ?", [element]).then(result => result[0]))
        })
      }
      return returnObj
    }
  },
  Exercise: { // TODO fix the rest of them to match these examples
    musclegroups(parent) {
      let returnObj = []
      if (parent.musclegroups != null) {
        parent.musclegroups.forEach(element => {
          returnObj.push(querySQLDB("SELECT * FROM musclegroup WHERE id = ?", [element]).then(result => result[0]))
        })
      }
      return returnObj
    },
    equipment(parent) {
      let returnObj = []
      if (parent.equipment != null) {
        parent.equipment.forEach(element => {
          returnObj.push(querySQLDB("SELECT * FROM equipment WHERE id = ?", [element]).then(result => result[0]))
        })
      }
      return returnObj
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
    addUser: (parent, { name, email, avatar }) => {
      return querySQLDB("INSERT into users (name, email, avatar) VALUES (?, ?, ?)", [name, email, avatar]).then(
        result => querySQLDB("SELECT * FROM users WHERE id = ?", [result.insertid]).then(result => result[0])
      )
    },
    addEquipment: (parent, { name, icon }) => {
      return querySQLDB("INSERT into equipment (name, icon) VALUES (?, ?)", [name, icon]).then(
        result => querySQLDB("SELECT * FROM equipment WHERE id = ?", [result.insertid]).then(result => result[0])
      )
    },
    addMuscleGroup: (parent, { name, picture }) => {
      return querySQLDB("INSERT into musclegroup (name, picture) VALUES (?, ?)", [name, picture]).then(
        result => querySQLDB("SELECT * FROM musclegroup WHERE id =BB ?", [result.insertid]).then(result => result[0])
      )
    },
    // TODO need to make the rest of the adds and then all of the updates
  }
}

exports.resolvers = resolvers
