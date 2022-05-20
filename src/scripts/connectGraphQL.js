import { ApolloClient, InMemoryCache, gql } from "@apollo/client/core";
import { persistCache, LocalStorageWrapper } from 'apollo3-cache-persist';

// Setup apollo client:
const cache = new InMemoryCache()
export let forceNetworkJQL = true

persistCache({
  cache,
  storage: new LocalStorageWrapper(window.localStorage)
})

export const client = new ApolloClient({
  // uri: "https://5ipdns9qfj.execute-api.us-east-1.amazonaws.com/dev/",
  uri: "http://localhost:4000",
  cache: cache
});
