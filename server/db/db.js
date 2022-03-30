const mysql = require('mysql2')
if (process.env.MODE != null) {
  require('dotenv').config({ path: './aws.env' })
}
else {
  require('dotenv').config({ path: './local.env' })
}

const connectSQLDB = function () {
  console.log("connectSQLDB()...")
  // console.log(process.env.HOST, process.env.DBUSER, process.env.PASSWORD, process.env.DB)
  let retVal = mysql.createConnection({
    host: process.env.HOST,
    port: 3306,
    user: process.env.DBUSER,
    password: process.env.PASSWORD,
    database: process.env.DB,
    multipleStatements: true
  })
  retVal.on('error', function (err) {
    console.log("It's dead, Jim...", err)
  })
  return retVal
}

const querySQLDB = (sql, values) => {
  let connection = connectSQLDB()
  return new Promise((resolve, reject) => connection.execute(sql, values, (error, results, fields) => {
    // console.log('querySQLDB error', error)
    // console.log('querySQLDB results', results)
    // console.log('querySQLDB fields', fields)
    if (error) reject(error)
    else resolve(results)
  }))
}

exports.connectSQLDB = connectSQLDB
exports.querySQLDB = querySQLDB
