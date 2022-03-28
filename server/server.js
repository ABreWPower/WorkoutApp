let ApolloServer
if (process.env.MODE != null) {
  console.log("lamdba")
  ApolloServer = require('apollo-server-lambda').ApolloServer
}
else {
  console.log("local")
  ApolloServer = require('apollo-server').ApolloServer
}

const { resolvers } = require('./resolvers/resolvers.js')
const { readFileSync } = require('fs')

const typeDefs = readFileSync('./schema/schema.graphql').toString('utf-8')

// The ApolloServer constructor requires two parameters: your schema
// definition and your set of resolvers.
const server = new ApolloServer({ typeDefs, resolvers });

// Only for test purposes when using node server
// require('./db/setupdb.js')


if (process.env.MODE != null) {
  exports.graphqlHandler = server.createHandler();
}
else {
  server.listen().then(({ url }) => {
    console.log(`🚀 Server ready at ${url}`);
  });
}
