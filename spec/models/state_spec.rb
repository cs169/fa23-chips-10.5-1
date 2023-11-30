require 'rails_helper'

describe State, type: :model do 
  describe 'std_fips_code' do
    it 'returns the correct FIPS code' do
      state = State.new(name: 'California', fips_code: '6')
      expect(state.std_fips_code).to eq('06')
    end 
  end 
end 