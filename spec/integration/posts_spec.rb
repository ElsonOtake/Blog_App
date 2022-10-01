require 'swagger_helper'

describe 'Posts API' do
  path 'api/v1/users' do
    get 'Retrieves users' do
      tags 'Users'
      consumes 'application/json'

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
        run_test!
      end
    end
  end

  path '/api/v1/auth/login' do
    post 'Log in' do
      tags 'Log in'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
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

  path 'api/v1/users/{id}' do
    get 'Retrieves a user' do
      tags 'User'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

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
        let(:header) { { authorization: token } }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'User not found' } }
        run_test!
      end
    end
  end

  path 'api/v1/users/{id}/posts' do
    get 'Retrieves posts of users(id)' do
      tags 'Posts', 'User'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 text: { type: :string },
                 comments_counter: { type: :integer },
                 likes_counter: { type: :integer },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 author_id: { type: :integer }
               }
        let(:header) do
          { authorization: token }
        end
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'Posts not found' } }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'User not found' } }
        run_test!
      end
    end
  end

  path 'api/v1/users/{user_id}/posts/{id}' do
    get 'Retrieves a post' do
      tags 'Posts', 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 text: { type: :string },
                 comments_counter: { type: :integer },
                 likes_counter: { type: :integer },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 author_id: { type: :integer }
               }
        let(:header) do
          { authorization: token }
        end
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'Post not found' } }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { { error: 'User not found' } }
        run_test!
      end
    end
  end

  path 'api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieve comments' do
      tags 'Posts', 'Users', 'Comments'
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
        let(:id) { { error: 'User and/or post not found' } }
        run_test!
      end
    end
  end

  path 'api/v1/users/{user_id}/posts/{post_id}/comments/{id}' do
    get 'Retrieves a comment' do
      tags 'Posts', 'Users', 'Comments'
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
end
