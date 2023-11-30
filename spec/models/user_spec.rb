require 'rails_helper'

describe User, type: :model do 
  describe 'find_google_user' do
    it 'successfully finds user by uid and google provider' do
      user_id = '123'
      user = User.create(provider: :google_oauth2, uid: user_id)
      
      expect(User.find_google_user(user_id)).to eq(user)
    end
  end

  describe 'find_github_user' do
    it 'successfully finds user by uid and github provider' do
      user_id = '123'
      user = User.create(provider: :github, uid: user_id)
      
      expect(User.find_github_user(user_id)).to eq(user)
    end
  end
end 