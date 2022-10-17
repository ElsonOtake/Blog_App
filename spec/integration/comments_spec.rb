require 'swagger_helper'

describe 'Comments' do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves comments' do
      security [{ ApiKeyAuth: [] }]
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, required: true, description: 'user id'
      parameter name: :post_id, in: :path, type: :string, required: true, description: 'post id'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          text: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string },
          author_id: { type: :integer },
          post_id: { type: :integer }
        }
        let(:id) do
          { authorization: token }
        end
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'User and/or post not found' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments/{id}' do
    get 'Retrieve a comment' do
      security [{ ApiKeyAuth: [] }]
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, required: true, description: 'user id'
      parameter name: :post_id, in: :path, type: :string, required: true, description: 'post id'
      parameter name: :id, in: :path, type: :string, required: true, description: 'comment id'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          text: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string },
          author_id: { type: :integer },
          post_id: { type: :integer }
        }
        let(:post_id) { :post_id }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'User/Post/Comment not found' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    post 'Create a comment' do
      security [{ ApiKeyAuth: [] }]
      tags 'Comments'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string, required: true, description: 'user id'
      parameter name: :post_id, in: :path, type: :string, required: true, description: 'post id'
      parameter name: :id, in: :body, description: 'Create a comment', schema: {
        type: :object, properties: {
                         text: { type: :string }
                       },
        required: %w[text]
      }

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          text: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string },
          author_id: { type: :integer },
          post_id: { type: :integer }
        }
        let(:post_id) { :post_id }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'User and/or post not found' }
        run_test!
      end
    end
  end
end
