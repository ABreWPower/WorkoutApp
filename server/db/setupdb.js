const { connectSQLDB, querySQLDB } = require('./db.js')

// This script will setup the basics needed for the project in the AWS RDS database

console.log("start building the sql environment")

// **************
// Create tables:
// **************

// querySQLDB(`
//   CREATE TABLE user (
//     id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//     name varchar(255) NOT NULL, 
//     email varchar(255),
//     avatar varchar(255)
//   )
// `)

// querySQLDB(`
//   CREATE TABLE workout (
//     id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//     name varchar(255) NOT NULL, 
//     picture varchar(255),
//     description varchar(255),
//     user int,
//     duration int,
//     difficulty int,
//     equipment json,
//     exercises json
//   )
// `)

// querySQLDB(`
//   CREATE TABLE exercise (
//     id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//     name varchar(255) NOT NULL, 
//     video varchar(255),
//     picture varchar(255),
//     instructions varchar(255),
//     difficulty int,
//     musclegroups json,
//     reps int,
//     duration int,
//     equipment json
//   )
// `)

// querySQLDB(`
//   CREATE TABLE equipment (
//     id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//     name varchar(255) NOT NULL, 
//     icon varchar(255)
//   )
// `)

// querySQLDB(`
//   CREATE TABLE musclegroup (
//     id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//     name varchar(255) NOT NULL, 
//     picture varchar(255)
//   )
// `)

// querySQLDB(`
//   CREATE TABLE workoutlog (
//     id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//     user json NOT NULL, 
//     workout json NOT NULL, 
//     totalduration int,
//     starteddatetime int,
//     wlexercises json
//   )
// `)

// querySQLDB(`
//   CREATE TABLE workoutlogexercise (
//     id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
//     workoutlog int NOT NULL, 
//     exercise int NOT NULL, 
//     sets int,
//     reps int,
//     duration int,
//     rest int,
//     weight int,
//     actualduration int
//   )
// `)


// ************
// Create users
// ************

// querySQLDB(`
//   INSERT INTO user (name, email)
//             VALUES ("John Smith", "john.smith@email.com")
// `)

// querySQLDB(`
//   INSERT INTO user (name, email)
//             VALUES ("Adam Smith", "jane.smith@email.com")
// `)

// querySQLDB(`
//   INSERT INTO user (name, email)
//             VALUES ("Patrick Smith", "jane.smith@email.com")
// `)

console.log(querySQLDB("SELECT * FROM user").then(result => result))


console.log(querySQLDB("SELECT * FROM workout").then(result => result))
console.log(querySQLDB("SELECT * FROM exercise").then(result => result))
console.log(querySQLDB("SELECT * FROM equipment").then(result => result))
console.log(querySQLDB("SELECT * FROM musclegroup").then(result => result))
console.log(querySQLDB("SELECT * FROM workoutlog").then(result => result))
console.log(querySQLDB("SELECT * FROM workoutlogexercise").then(result => result))


console.log("finished building the sql environment")
