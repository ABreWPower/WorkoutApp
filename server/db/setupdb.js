const { connectSQLDB, querySQLDB } = require('./db.js')

// This script will setup the basics needed for the project in the AWS RDS database

console.log("start building the sql environment")

// ***************************************
// Clear the database to ensure clean data
// ***************************************

querySQLDB('DROP TABLE user')
querySQLDB('DROP TABLE workout')
querySQLDB('DROP TABLE exercise')
querySQLDB('DROP TABLE equipment')
querySQLDB('DROP TABLE musclegroup')
querySQLDB('DROP TABLE workoutlog')
querySQLDB('DROP TABLE workoutlogexercise')


// **************
// Create tables:
// **************

querySQLDB(`
  CREATE TABLE user (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    email varchar(255),
    avatar varchar(255)
  )
`)

querySQLDB(`
  CREATE TABLE workout (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    picture varchar(255),
    description varchar(255),
    user int,
    duration int,
    difficulty int,
    equipment json,
    exercises json
  )
`)

querySQLDB(`
  CREATE TABLE exercise (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    video varchar(255),
    picture varchar(255),
    instructions varchar(255),
    difficulty int,
    musclegroups json,
    reps int,
    duration int,
    equipment json
  )
`)

querySQLDB(`
  CREATE TABLE equipment (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    icon varchar(255)
  )
`)

querySQLDB(`
  CREATE TABLE musclegroup (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    picture varchar(255)
  )
`)

querySQLDB(`
  CREATE TABLE workoutlog (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    user json NOT NULL, 
    workout json NOT NULL, 
    totalduration int,
    starteddatetime int,
    wlexercises json
  )
`)

querySQLDB(`
  CREATE TABLE workoutlogexercise (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    workoutlog int NOT NULL, 
    exercise int NOT NULL, 
    sets int,
    reps int,
    duration int,
    rest int,
    weight int,
    actualduration int
  )
`)

// ************
// Create users
// ************

querySQLDB(`
  INSERT INTO user (name, email)
            VALUES ("John Smith", "john.smith@email.com")
`)

querySQLDB(`
  INSERT INTO user (name, email)
            VALUES ("Adam Smith", "adam.smith@email.com")
`)

querySQLDB(`
  INSERT INTO user (name, email)
            VALUES ("Patrick Smith", "patrick.smith@email.com")
`)

console.log(querySQLDB("SELECT * FROM user").then(result => result))

// ****************
// Create equipment
// ****************

querySQLDB(`
  INSERT INTO equipment (name)
            VALUES ("Dumbbell")
`)

querySQLDB(`
  INSERT INTO equipment (name)
            VALUES ("Bench")
`)

querySQLDB(`
  INSERT INTO equipment (name)
            VALUES ("Treadmill")
`)

console.log(querySQLDB("SELECT * FROM equipment").then(result => result))

// ******************
// Create musclegroup
// ******************

querySQLDB(`
  INSERT INTO musclegroup (name)
            VALUES ("Chest")
`)

querySQLDB(`
  INSERT INTO musclegroup (name)
            VALUES ("Abs")
`)

querySQLDB(`
  INSERT INTO musclegroup (name)
            VALUES ("Quadriceps")
`)

querySQLDB(`
  INSERT INTO musclegroup (name)
            VALUES ("Tricep")
`)

querySQLDB(`
  INSERT INTO musclegroup (name)
            VALUES ("Bicep")
`)

console.log(querySQLDB("SELECT * FROM musclegroup").then(result => result))

// ***************
// Create exercise
// ***************

querySQLDB(`
  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
            VALUES ("Chinup", "Pull your self up on a bar", 2, "[1, 2]", 10, null, "[1]")
`)

querySQLDB(`
  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
            VALUES ("Pullup", "Pull your self up on a bar", 3, "[1, 2]", 15, null, "[2]")
`)

querySQLDB(`
  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
            VALUES ("Pushup", "Push off of the ground", 1, "[1, 2]", 20, null, "[3]")
`)

querySQLDB(`
  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
            VALUES ("Bicep Curl", "Curl arms up holding a bar or dumbbell", 2, "[1, 4]", 12, null, "[1, 2]")
`)

querySQLDB(`
  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
            VALUES ("Skull Crusher", "lower weight near your head while on bench", 2, "[1, 5]", 8, null, "[1, 2]")
`)

querySQLDB(`
  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
            VALUES ("Plank", "On elbow and toes with body straight out", 2, null, null, 60, null)
`)

console.log(querySQLDB("SELECT * FROM exercise").then(result => result))

// ***************
// Create workouts
// ***************

querySQLDB(`
  INSERT INTO workout (name, description, user)
            VALUES ("John Smith", "john.smith@email.com")
`)

console.log(querySQLDB("SELECT * FROM workout").then(result => result))


console.log(querySQLDB("SELECT * FROM exercise").then(result => result))


console.log(querySQLDB("SELECT * FROM workoutlog").then(result => result))
console.log(querySQLDB("SELECT * FROM workoutlogexercise").then(result => result))


console.log("finished building the sql environment")
