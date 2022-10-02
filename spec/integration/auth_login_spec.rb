require 'swagger_helper'

describe 'Auth login' do
  path '/api/v1/auth/login' do
    post 'Valid user log in' do
      tags 'Log in'
      consumes 'application/json'
      parameter name: :user, in: :body, description: 'Valid user log in', schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 token: { type: :string },
                 exp: { type: :string },
                 email: { type: :string }
               }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { { error: 'unauthorized' } }
        run_test!
      end
    end
  end
end
