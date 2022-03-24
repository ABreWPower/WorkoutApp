const mysql = require('mysql')
require('dotenv').config()

const connectSQLDB = function () {
  console.log("connectSQLDB()...")
  let retVal = mysql.createConnection({
    host: process.env.HOST,
    port: 3306,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DB
  })
  retVal.on('error', function (err) {
    console.log("It's dead, Jim...", err)
  })
  return retVal
}

const querySQLDB = sql => {
  let connection = connectSQLDB()
  return new Promise((resolve, reject) => connection.query(sql, (error, results, fields) => {
    console.log('querySQLDB error', error)
    console.log('querySQLDB results', results)
    console.log('querySQLDB fields', fields)
    if (error) reject(error)
    else resolve(results)
  }))
}

exports.connectSQLDB = connectSQLDB
exports.querySQLDB = querySQLDB
