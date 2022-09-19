require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /' do
    before(:each) do
      get '/'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template users/index' do
      expect(response).to render_template('users/index')
    end
    it 'body include the placeholder "Here is a list of users"' do
      expect(response.body).to include('Here is a list of users')
    end
    it 'body include the path app/views/users/index.html.erb' do
      expect(response.body).to include('app/views/users/index.html.erb')
    end
  end

  describe 'GET /users' do
    before(:each) do
      get '/users'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template users/index' do
      expect(response).to render_template('users/index')
    end
    it 'body include the placeholder "Here is a list of users"' do
      expect(response.body).to include('Here is a list of users')
    end
    it 'body include the path app/views/users/index.html.erb' do
      expect(response.body).to include('app/views/users/index.html.erb')
    end
  end

  describe 'GET /users/1' do
    before(:each) do
      get '/users/1'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template users/show' do
      expect(response).to render_template('users/show')
    end
    it 'body include the placeholder "Here is a detail for a given user"' do
      expect(response.body).to include('Here is a detail for a given user')
    end
    it 'body include the path app/views/users/show.html.erb' do
      expect(response.body).to include('app/views/users/show.html.erb')
    end
  end

  describe 'GET /users/index' do
    before(:each) do
      get '/users/index'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'not render template users/index' do
      expect(response).to_not render_template('users/index')
    end
    it 'render template users/show' do
      expect(response).to render_template('users/show')
    end
    it 'body include the path app/views/users/show.html.erb' do
      expect(response.body).to include('app/views/users/show.html.erb')
    end
  end

  describe 'GET /users/show' do
    before(:each) do
      get '/users/show'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template users/show' do
      expect(response).to render_template('users/show')
    end
    it 'body include the placeholder "Here is a detail for a given user"' do
      expect(response.body).to include('Here is a detail for a given user')
    end
    it "body doesn't include the placeholder 'Here is a list of users'" do
      expect(response.body).to_not include('Here is a list of users')
    end
    it 'body include the path app/views/users/show.html.erb' do
      expect(response.body).to include('app/views/users/show.html.erb')
    end
  end
end
