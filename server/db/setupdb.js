const { connectSQLDB, querySQLDB } = require('./db.js')

// This script will setup the basics needed for the project in the AWS RDS database

console.log("start building the sql environment")

querySQLDB(`
  CREATE TABLE user (
    ID int, 
    name varchar(255), 
    email varchar(255),
    avatar varchar(255)
  )
`)

querySQLDB(`
  INSERT INTO user (name, email)
            VALUES ("John Smith", "john.smith@email.com")
`)

console.log(querySQLDB("SELECT * FROM user").then(result => result))

console.log("finished building the sql environment")
