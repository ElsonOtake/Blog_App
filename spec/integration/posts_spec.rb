require 'swagger_helper'

describe 'Posts' do
  path '/api/v1/users/{id}/posts' do
    get 'Retrieves posts' do
      security [{ ApiKeyAuth: [] }]
      tags 'Posts'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, required: true, description: 'user id'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          title: { type: :string },
          text: { type: :string },
          comments_counter: { type: :integer },
          likes_counter: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string },
          author_id: { type: :integer }
        }
        let(:comments_counter) { 0 }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'User/Post not found' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{id}' do
    get 'Retrieve a post' do
      security [{ ApiKeyAuth: [] }]
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, required: true, description: 'user id'
      parameter name: :id, in: :path, type: :string, required: true, description: 'post id'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          title: { type: :string },
          text: { type: :string },
          comments_counter: { type: :integer },
          likes_counter: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string },
          author_id: { type: :integer }
        }
        let(:comments_counter) { 0 }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'User/Post not found' }
        run_test!
      end
    end
  end
end
