import { ApolloClient, InMemoryCache, gql } from "@apollo/client/core";
import { persistCache, LocalStorageWrapper } from 'apollo3-cache-persist';

// Setup apollo client:
const cache = new InMemoryCache({
  typePolicies: {
    Exercise: {
      keyFields: ["id", "reps", "duration", "rest", "type"]
    }
  }
})
export let forceNetworkJQL = true

let apolloUri = `http://${window.location.hostname}:4000/`
if (window.location.hostname === "workoutapp.adamwickersham.com") {
  apolloUri = "https://5ipdns9qfj.execute-api.us-east-1.amazonaws.com/dev/"
}

persistCache({
  cache,
  storage: new LocalStorageWrapper(window.localStorage)
})

export const client = new ApolloClient({
  uri: apolloUri,
  cache: cache,
  defaultOptions: {
    watchQuery: {
      fetchPolicy: 'cache-and-network',
      errorPolicy: 'all'
    },
    query: {
      fetchPolicy: 'network-only',
      errorPolicy: 'all'
    }
  }
})
