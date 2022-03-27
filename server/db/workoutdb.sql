DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS workout;
DROP TABLE IF EXISTS exercise;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS musclegroup;
DROP TABLE IF EXISTS workoutlog;
DROP TABLE IF EXISTS workoutlogexercise;


  CREATE TABLE user (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    email varchar(255),
    avatar varchar(255)
  )
;


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
;


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
;


  CREATE TABLE equipment (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    icon varchar(255)
  )
;


  CREATE TABLE musclegroup (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(255) NOT NULL, 
    picture varchar(255)
  )
;


  CREATE TABLE workoutlog (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    user int NOT NULL, 
    workout int NOT NULL, 
    totalduration int,
    starteddatetime int,
    wlexercises json
  )
;


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
;


  INSERT INTO user (name, email)
            VALUES ("John Smith", "john.smith@email.com")
;


  INSERT INTO user (name, email)
            VALUES ("Adam Smith", "adam.smith@email.com")
;


  INSERT INTO user (name, email)
            VALUES ("Patrick Smith", "patrick.smith@email.com")
;



  INSERT INTO equipment (name)
                 VALUES ("Dumbbell")
;


  INSERT INTO equipment (name)
                 VALUES ("Bench")
;


  INSERT INTO equipment (name)
                 VALUES ("Treadmill")
;




  INSERT INTO musclegroup (name)
                   VALUES ("Chest")
;


  INSERT INTO musclegroup (name)
                   VALUES ("Abs")
;


  INSERT INTO musclegroup (name)
                   VALUES ("Quadriceps")
;


  INSERT INTO musclegroup (name)
                   VALUES ("Tricep")
;


  INSERT INTO musclegroup (name)
                   VALUES ("Bicep")
;


  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
                VALUES ("Chinup", "Pull your self up on a bar", 2, "[1, 2]", 10, null, "[1]")
;


  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
                VALUES ("Pullup", "Pull your self up on a bar", 3, "[1, 2]", 15, null, "[2]")
;


  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
                VALUES ("Pushup", "Push off of the ground", 1, "[1, 2]", 20, null, "[3]")
;


  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
                VALUES ("Bicep Curl", "Curl arms up holding a bar or dumbbell", 2, "[1, 4]", 12, null, "[1, 2]")
;


  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
                VALUES ("Skull Crusher", "lower weight near your head while on bench", 2, "[1, 5]", 8, null, "[1, 2]")
;


  INSERT INTO exercise (name, instructions, difficulty, musclegroups, reps, duration, equipment)
                VALUES ("Plank", "On elbow and toes with body straight out", 2, null, null, 60, null)
;




  INSERT INTO workout (name, description, user, duration, difficulty, equipment, exercises)
               VALUES ("Workout 1", "Lots of workouts", 1, 90, 2, "[1, 2]", "[1, 2, 3, 4, 5]")
;


  INSERT INTO workout (name, description, user, duration, difficulty, equipment, exercises)
               VALUES ("Super B", "Hard workout", 2, 60, 3, "[2, 3]", "[1, 3, 5, 2]")
;


  INSERT INTO workout (name, description, user, duration, difficulty, equipment, exercises)
               VALUES ("Short", "Small number of exercies", 3, 30, 1, "[1, 3]", "[6, 2, 4]")
;

