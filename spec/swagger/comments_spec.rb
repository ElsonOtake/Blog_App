require 'swagger_helper'

describe 'Comments' do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves comments' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
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
        let(:id) { { error: 'User and/or post not found' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments/{id}' do
    get 'Retrieve a comment' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 text: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 author_id: { type: :integer },
                 post_id: { type: :integer }
               }
        let(:header) do
          { authorization: token }
        end
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'Comment not found' } }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'User and/or post not found' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    post 'Create a comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :id, in: :body, description: 'Create a comment', schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: %w[text]
      }

      response '200', 'OK' do
        let(:id) do
          { id: 1,
            text: 'This is a new comment',
            created_at: '2022-10-02T16:50:59.888Z',
            updated_at: '2022-10-02T16:50:59.888Z',
            author_id: 18,
            post_id: 27 }
        end
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'User and/or post not found' } }
        run_test!
      end
    end
  end
end
