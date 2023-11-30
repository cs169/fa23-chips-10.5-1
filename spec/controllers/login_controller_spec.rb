# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'GET #google_oauth2' do
    it 'creates a new session' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      get :google_oauth2
      expect(session[:current_user_id]).not_to be_nil
    end
  end

  describe 'GET #github' do
    it 'creates a new session' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
      get :github
      expect(session[:current_user_id]).not_to be_nil
    end
  end

  describe 'GET #logout' do
    it 'destroys the session' do
      session[:current_user_id] = user.id
      get :logout
      expect(session[:current_user_id]).to be_nil
    end
  end
end
