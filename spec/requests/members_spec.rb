require 'rails_helper'

RSpec.describe 'Members', type: :request do
  before(:each) do
    @member = FactoryBot.create(:member)
    sign_in @member
  end

  describe 'GET /' do
    before(:each) do
      get root_path
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render index template' do
      expect(response).to render_template('members/index')
    end
  end

  describe 'GET /members' do
    before(:each) do
      get '/members'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render index template' do
      expect(response).to render_template('members/index')
    end
    it 'body include the API endpoints link' do
      expect(response.body).to include('API endpoints')
    end
    it 'body include the Add post link' do
      expect(response.body).to include('Add post')
    end
    it 'body include the Analytics link' do
      expect(response.body).to include('Analytics')
    end
    it 'body include the Edit profile link' do
      expect(response.body).to include('Edit profile')
    end
    it 'body include the Sign out link' do
      expect(response.body).to include('Sign out')
    end
  end
end
