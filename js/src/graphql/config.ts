import gql from 'graphql-tag';

export const CONFIG = gql`
query {
  config {
    name,
    description,
    registrationsOpen,
    countryCode,
    location {
      latitude,
      longitude,
      accuracyRadius
    },
    maps {
      tiles {
        endpoint,
        attribution
      }
    },
    geocoding {
      provider,
      autocomplete
    }
  }
}
`;
