require 'rails_helper'
RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Blog app API V1',
        description: 'To run the endpoints. Open the endpoint. Click the "Try it out" button. Fill in the parameters, if necessary, and click the "Execute" button. \
          \
          Endpoints with an open lock require the user to be logged in. Execute the login endpoint and copy the generated token. Click the "Authorize" button at the top of the main page, \
          paste the token, and click the "Authorize" button.',
        version: 'v1'
      },
      paths: {},
      servers: [{
        url: 'http://localhost:3000',
        variables: {
          defaultHost: { default: 'localhost:3000' }
        }
      }],
      components: {
        securitySchemes: {
          ApiKeyAuth: {
            type: 'apiKey',
            in: 'header',
            name: 'Authorization'
          }
        }
      }
    }
  }
  config.swagger_format = :yaml
end
