const { connectSQLDB, querySQLDB } = require('./db.js')
const { readFileSync } = require('fs')

// This script will setup the basics needed for the project in the AWS RDS database

console.log("start building the sql environment")

const cmds = readFileSync('./db/workoutdb.sql').toString('utf-8')
querySQLDB(cmds).then(results => console.log("finished building the sql environment")).catch(
  error => console.log("error", error)
)

// // ************
// // Create users
// // ************

// querySQLDB('DROP TABLE IF EXISTS users').then(results => {
//   querySQLDB(`
//     CREATE TABLE users (
//       id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//       name varchar(255) NOT NULL, 
//       email varchar(255),
//       avatar varchar(255)
//     )
//   `).then(results => {
//     querySQLDB(`
//       INSERT INTO users (name, email)
//                 VALUES ("John Smith", "john.smith@email.com")
//     `)

//     querySQLDB(`
//       INSERT INTO users (name, email)
//                 VALUES ("Adam Smith", "adam.smith@email.com")
//     `)

//     querySQLDB(`
//       INSERT INTO users (name, email)
//                 VALUES ("Patrick Smith", "patrick.smith@email.com")
//     `)

//     console.log(querySQLDB("SELECT * FROM users").then(result => result))
//   })
// })


// // ****************
// // Create equipment
// // ****************

// querySQLDB('DROP TABLE IF EXISTS equipment').then(results => {
//   querySQLDB(`
//     CREATE TABLE equipment (
//       id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//       name varchar(255) NOT NULL, 
//       icon varchar(255)
//     )
//   `).then(results => {

//     querySQLDB(`
//       INSERT INTO equipment (name)
//                      VALUES ("Dumbbell")
//     `)

//     querySQLDB(`
//       INSERT INTO equipment (name)
//                      VALUES ("Bench")
//     `)

//     querySQLDB(`
//       INSERT INTO equipment (name)
//                      VALUES ("Treadmill")
//     `)

//     console.log(querySQLDB("SELECT * FROM equipment").then(result => result))
//   })
// })

// // ******************
// // Create musclegroup
// // ******************

// querySQLDB('DROP TABLE IF EXISTS musclegroup').then(results => {
//   querySQLDB(`
//     CREATE TABLE musclegroup (
//       id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//       name varchar(255) NOT NULL, 
//       picture varchar(255)
//     )
//   `).then(results => {
//     querySQLDB(`
//       INSERT INTO musclegroup (name)
//                        VALUES ("Chest")
//     `)

//     querySQLDB(`
//       INSERT INTO musclegroup (name)
//                        VALUES ("Abs")
//     `)

//     querySQLDB(`
//       INSERT INTO musclegroup (name)
//                        VALUES ("Quadriceps")
//     `)

//     querySQLDB(`
//       INSERT INTO musclegroup (name)
//                        VALUES ("Tricep")
//     `)

//     querySQLDB(`
//       INSERT INTO musclegroup (name)
//                        VALUES ("Bicep")
//     `)

//     console.log(querySQLDB("SELECT * FROM musclegroup").then(result => result))
//   })
// })

// // ***************
// // Create exercise
// // ***************

// querySQLDB('DROP TABLE IF EXISTS exercise').then(results => {
//   querySQLDB(`
//     CREATE TABLE exercise (
//       id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//       name varchar(255) NOT NULL, 
//       video varchar(255),
//       picture varchar(255),
//       instructions varchar(255),
//       difficulty int,
//       musclegroups json,
//       reps int,
//       duration int,
//       equipment json
//     )
//   `).then(results => {
//     querySQLDB(`
//       INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
//                     VALUES ("Chinup", "Pull your self up on a bar", 2, "[1, 2]", 10, null, "[1]")
//     `)

//     querySQLDB(`
//       INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
//                     VALUES ("Pullup", "Pull your self up on a bar", 3, "[1, 2]", 15, null, "[2]")
//     `)

//     querySQLDB(`
//       INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
//                     VALUES ("Pushup", "Push off of the ground", 1, "[1, 2]", 20, null, "[3]")
//     `)

//     querySQLDB(`
//       INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
//                     VALUES ("Bicep Curl", "Curl arms up holding a bar or dumbbell", 2, "[1, 4]", 12, null, "[1, 2]")
//     `)

//     querySQLDB(`
//       INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
//                     VALUES ("Skull Crusher", "lower weight near your head while on bench", 2, "[1, 5]", 8, null, "[1, 2]")
//     `)

//     querySQLDB(`
//       INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
//                     VALUES ("Plank", "On elbow and toes with body straight out", 2, null, null, 60, null)
//     `)

//     console.log(querySQLDB("SELECT * FROM exercise").then(result => result))
//   })
// })

// // ***************
// // Create workouts
// // ***************

// querySQLDB('DROP TABLE IF EXISTS workout').then(results => {
//   querySQLDB(`
//     CREATE TABLE workout (
//       id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//       name varchar(255) NOT NULL, 
//       picture varchar(255),
//       description varchar(255),
//       user int,
//       duration int,
//       difficulty int,
//       equipment json,
//       exercises json
//     )
//   `).then(results => {
//     querySQLDB(`
//       INSERT INTO workout (name, description, user, duration, difficulty, equipment, exercises)
//                    VALUES ("Workout 1", "Lots of workouts", 1, 90, 2, "[1, 2]", "[1, 2, 3, 4, 5]")
//     `)

//     querySQLDB(`
//       INSERT INTO workout (name, description, user, duration, difficulty, equipment, exercises)
//                    VALUES ("Super B", "Hard workout", 2, 60, 3, "[2, 3]", "[1, 3, 5, 2]")
//     `)

//     querySQLDB(`
//       INSERT INTO workout (name, description, user, duration, difficulty, equipment, exercises)
//                    VALUES ("Short", "Small number of exercies", 3, 30, 1, "[1, 3]", "[6, 2, 4]")
//     `)


//     console.log(querySQLDB("SELECT * FROM workout").then(result => result))
//   })
// })

// // *****************
// // Create workoutlog
// // *****************
// querySQLDB('DROP TABLE IF EXISTS workoutlog').then(results => {
//   querySQLDB(`
//     CREATE TABLE workoutlog (
//       id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//       user int NOT NULL, 
//       workout int NOT NULL, 
//       totalduration int,
//       starteddatetime int,
//       wlexercises json
//     )
//   `).then(results => {
//     // TODO make the defualt data for test purposes here

//     console.log(querySQLDB("SELECT * FROM workoutlog").then(result => result))
//   })
// })

// // *************************
// // Create workoutlogexercise
// // *************************

// querySQLDB('DROP TABLE IF EXISTS workoutlogexercise').then(results => {
//   querySQLDB(`
//     CREATE TABLE workoutlogexercise (
//       id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//       workoutlog int NOT NULL, 
//       exercise int NOT NULL, 
//       sets int,
//       reps int,
//       duration int,
//       rest int,
//       weight int,
//       actualduration int
//     )
//   `).then(results => {
//     // TODO make the defualt data for test purposes here

//     console.log(querySQLDB("SELECT * FROM workoutlogexercise").then(result => result))
//   })
// })


