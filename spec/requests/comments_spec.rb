require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before(:each) do
    @member = FactoryBot.create(:member)
    @post = @member.posts.create(title: "MyTitle", text: "MyText")
    sign_in @member
  end
  describe 'Test instance variables' do
    it 'check that a member can be created' do
      expect(@member).to be_valid
    end
    it 'check that a post can be created' do
      expect(@post).to be_valid
    end
  end
  describe 'GET /members/:@member/posts/:post/comments/new' do
    it "render template new" do
      get new_member_post_comment_path(@member, @post)
      expect(response).to render_template(:new)
    end
  end
  describe 'POST /members/:@member/posts/:post/comments' do
    it "return http success" do
      current_user = @member
      post member_post_comments_path(@member, @post), params: { comment: {text: "My Text"} }
      expect(response).to_not have_http_status(:success)
    end
  end
end
