const { connectSQLDB, querySQLDB } = require('./db.js')
const { readFileSync } = require('fs')

// This script will setup the basics needed for the project in the AWS RDS database

console.log("start building the sql environment")

const cmds = readFileSync('./db/workoutdb.sql').toString('utf-8')
querySQLDB(cmds).then(results => console.log("finished building the sql environment")).catch(
  error => console.log("error", error)
)
