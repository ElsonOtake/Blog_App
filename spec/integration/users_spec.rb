require 'swagger_helper'

describe 'Users' do
  path '/api/v1/users' do
    get 'Retrieves users' do
      tags 'Users'
      consumes 'application/json'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          bio: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string },
          photo: { type: :string },
          post_counter: { type: :integer },
          email: { type: :string },
          role: { type: :string }
        }
        let(:id) { 'valid' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Retrieve a user' do
      security [{ ApiKeyAuth: [] }]
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, required: true, description: 'user id'

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 bio: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 photo: { type: :string },
                 post_counter: { type: :integer },
                 email: { type: :string },
                 role: { type: :string }
               }
        let(:id) { :id }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'User not found' }
        run_test!
      end
    end
  end
end
