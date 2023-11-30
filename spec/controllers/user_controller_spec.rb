# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #profile' do
    context 'when user is logged in' do
      before do
        session[:current_user_id] = user.id
      end

      it 'assigns the requested user to @user' do
        get :profile
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :profile
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
