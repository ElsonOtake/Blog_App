require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    get '/posts/index'
  end
  describe 'GET /posts/index' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template posts/index' do
      expect(response).to render_template('posts/index')
    end
    it 'body include the placeholder "Here is a list of posts for a given user"' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
    it 'body include the path app/views/posts/index.html.erb' do
      expect(response.body).to include('app/views/posts/index.html.erb')
    end
  end

  describe 'GET /posts/show' do
    before(:each) do
      get '/posts/show'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template posts/show' do
      expect(response).to render_template('posts/show')
    end
    it 'body include the placeholder "Here is a detailed posts for a given user"' do
      expect(response.body).to include('Here is a detailed posts for a given user')
    end
    it "body doesn't include the placeholder 'Here is a list of posts for a given user'" do
      expect(response.body).to_not include('Here is a list of posts for a given user')
    end
    it 'body include the path app/views/posts/show.html.erb' do
      expect(response.body).to include('app/views/posts/show.html.erb')
    end
  end

  describe 'GET /users/1/posts' do
    before(:each) do
      get '/users/1/posts'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template posts/index' do
      expect(response).to render_template('posts/index')
    end
    it 'body include the placeholder "Here is a list of posts for a given user"' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
    it 'body include the path app/views/posts/index.html.erb' do
      expect(response.body).to include('app/views/posts/index.html.erb')
    end
  end

  describe 'GET /users/1/posts/2' do
    before(:each) do
      get '/users/1/posts/2'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template posts/show' do
      expect(response).to render_template('posts/show')
    end
    it 'body include the placeholder "Here is a detailed posts for a given user"' do
      expect(response.body).to include('Here is a detailed posts for a given user')
    end
    it 'body include the path app/views/posts/show.html.erb' do
      expect(response.body).to include('app/views/posts/show.html.erb')
    end
  end
end
