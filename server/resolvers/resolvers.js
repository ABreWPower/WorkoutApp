const mysql = require('mysql')

const connectSQLDB = function () {
  console.log("connectSQLDB()...")
  let retVal = mysql.createConnection({
    host: '',
    port: 3306,
    user: '',
    password: '',
    database: ''
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

// Resolvers define the technique for fetching the types defined in the
// schema. This resolver retrieves books from the "books" array above.
const resolvers = {
  Query: {
    books: () => querySQLDB("SELECT * FROM book").then(result => result),
    numberSix: () => "6",
    dateTime: () => querySQLDB("SELECT UTC_TIMESTAMP").then(result => String(result[0]['UTC_TIMESTAMP'])),
    authors: () => querySQLDB("SELECT * FROM author").then(result => result),
  },
  Book: {
    Authors(parent) {
      return querySQLDB({ sql: "SELECT author.* FROM author_book INNER JOIN author ON author_book.authorID = author.ID WHERE author_book.bookID = ?", values: parent.ID }).then(result => result)
    }
  },
  Author: {
    Books(parent) {
      return querySQLDB({ sql: "SELECT book.* FROM author_book INNER JOIN book ON author_book.bookID = book.ID WHERE author_book.authorID = ?", values: parent.ID }).then(result => result)
    }
  },
  Mutation: {
    addBook: (parent, { title }) => {
      return querySQLDB({ sql: "INSERT into book (Title) VALUES (?)", values: title }).then(
        result => querySQLDB({ sql: "SELECT * FROM book WHERE ID = ?", values: result.insertId }).then(result => result[0])
      )
    },
    addAuthor: (parent, { name }) => {
      return querySQLDB({ sql: "INSERT into author (Name) VALUES (?)", values: name }).then(
        result => querySQLDB({ sql: "SELECT * FROM author WHERE ID = ?", values: result.insertId }).then(result => result[0])
      )
    },
    addAuthorToBook: (parent, { bookID, authorID }) => {
      return querySQLDB({ sql: "INSERT into author_book (bookID, authorID) VALUES (?, ?)", values: [bookID, authorID] }).then(
        result => querySQLDB({ sql: "SELECT * FROM book WHERE ID = ?", values: bookID }).then(result => result[0])
      )
    }
  }
}

exports.resolvers = resolvers
