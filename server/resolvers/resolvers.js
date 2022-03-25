const { connectSQLDB, querySQLDB } = require('../db/db.js')

// TODO make a resolver and mutation that sets up the database for initial testing
// TODO make one that clears tables to clean up

// Resolvers define the technique for fetching the types defined in the
// schema. This resolver retrieves books from the "books" array above.
const resolvers = {
  Query: {
    users: () => querySQLDB("SELECT * FROM user").then(result => result),
    workouts: () => querySQLDB("SELECT * FROM workout").then(result => result),
    equipment: () => querySQLDB("SELECT * FROM equipment").then(result => result),
    musclegroups: () => querySQLDB("SELECT * FROM musclegroup").then(result => result),
    exercises: () => querySQLDB("SELECT * FROM exercise").then(result => result),
    workoutlogs: () => querySQLDB("SELECT * FROM workoutlog").then(result => result),
    workoutlogexercises: () => querySQLDB("SELECT * FROM workoutlogexercise").then(result => result),
  },
  Workout: {
    user(parent) {
      return querySQLDB({ sql: "SELECT * FROM user WHERE ID = ?", values: parent.user }).then(result => result[0])
    },
    equipment(parent) {
      return querySQLDB({ sql: "SELECT * FROM equipment WHERE ID = ?", values: parent.id }).then(result => result)
    },
    exercises(parent) {
      return querySQLDB({ sql: "SELECT * FROM exercise WHERE ID = ?", values: parent.id }).then(result => result)
    }
  },
  Exercise: {
    musclegroups(parent) {
      return querySQLDB({ sql: "SELECT * FROM musclegroup WHERE ID = ?", values: parent.id }).then(result => result)
    },
    equipment(parent) {
      return querySQLDB({ sql: "SELECT * FROM equipment WHERE ID = ?", values: parent.id }).then(result => result)
    }
  },
  WorkoutLog: {
    user(parent) {
      return querySQLDB({ sql: "SELECT * FROM user WHERE ID = ?", values: parent.id }).then(result => result)
    },
    workout(parent) {
      return querySQLDB({ sql: "SELECT * FROM workout WHERE ID = ?", values: parent.id }).then(result => result)
    },
    wlexercises(parent) {
      return querySQLDB({ sql: "SELECT * FROM workoutlogexercise WHERE ID = ?", values: parent.id }).then(result => result)
    }
  },
  WorkoutLogExercise: {
    workoutlog(parent) {
      return querySQLDB({ sql: "SELECT * FROM workoutlog WHERE ID = ?", values: parent.id }).then(result => result)
    },
    exercise(parent) {
      return querySQLDB({ sql: "SELECT * FROM exercise WHERE ID = ?", values: parent.id }).then(result => result)
    }
  },
  Mutation: {
    setupdb: () => {
      return require('../db/setupdb.js')
    }
  }



  // Book: {
  //   Authors(parent) {
  //     return querySQLDB({ sql: "SELECT author.* FROM author_book INNER JOIN author ON author_book.authorID = author.id WHERE author_book.bookID = ?", values: parent.id }).then(result => result)
  //   }
  // },
  // Mutation: {
  //   addBook: (parent, { title }) => {
  //     return querySQLDB({ sql: "INSERT into book (Title) VALUES (?)", values: title }).then(
  //       result => querySQLDB({ sql: "SELECT * FROM book WHERE ID = ?", values: result.insertId }).then(result => result[0])
  //     )
  //   },
  //   addAuthor: (parent, { name }) => {
  //     return querySQLDB({ sql: "INSERT into author (Name) VALUES (?)", values: name }).then(
  //       result => querySQLDB({ sql: "SELECT * FROM author WHERE ID = ?", values: result.insertId }).then(result => result[0])
  //     )
  //   },
  //   addAuthorToBook: (parent, { bookID, authorID }) => {
  //     return querySQLDB({ sql: "INSERT into author_book (bookID, authorID) VALUES (?, ?)", values: [bookID, authorID] }).then(
  //       result => querySQLDB({ sql: "SELECT * FROM book WHERE ID = ?", values: bookID }).then(result => result[0])
  //     )
  //   }
  // }
}

exports.resolvers = resolvers
