require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_visitor' do
    it 'reuses the visitor stored in the session' do
      visitor = Visitor.create!(user_agent: 'Test browser')
      session[:visitor_id] = visitor.id

      expect { expect(controller.current_visitor).to eq(visitor) }.not_to change(Visitor, :count)
    end

    it 'creates a visitor when the session has no visitor ID' do
      request.env['HTTP_USER_AGENT'] = 'Test browser'

      expect { controller.current_visitor }.to change(Visitor, :count).by(1)

      visitor = Visitor.find(session[:visitor_id])
      expect(visitor.user_agent).to eq('Test browser')
      expect(controller.current_visitor).to eq(visitor)
    end

    it 'replaces a stale visitor ID in the session' do
      visitor = Visitor.create!(user_agent: 'Old browser')
      session[:visitor_id] = visitor.id
      visitor.destroy!
      request.env['HTTP_USER_AGENT'] = 'Test browser'

      expect { controller.current_visitor }.to change(Visitor, :count).by(1)

      replacement = Visitor.find(session[:visitor_id])
      expect(replacement.id).not_to eq(visitor.id)
      expect(replacement.user_agent).to eq('Test browser')
      expect(controller.current_visitor).to eq(replacement)
    end
  end
end
