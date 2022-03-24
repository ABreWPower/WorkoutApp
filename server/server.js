const { ApolloServer } = require('apollo-server-lambda')
const { resolvers } = require('./resolvers/resolvers.js')
const { readFileSync } = require('fs')

const typeDefs = readFileSync('./schema/schema.graphql').toString('utf-8')

// The ApolloServer constructor requires two parameters: your schema
// definition and your set of resolvers.
const server = new ApolloServer({ typeDefs, resolvers });

require('./db/setupdb.js')

exports.graphqlHandler = server.createHandler();
