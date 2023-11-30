# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe AjaxController, type: :controller do
  describe 'counties' do
    it 'renders the JSON representation of @state.counties' do
      counties_arr = [{ name: 'Alameda' }, { name: 'Orange' }]
      state_double = instance_double(State, counties: counties_arr)
      allow(State).to receive(:find_by).and_return(state_double)
      get :counties, params: { state_symbol: 'CA' }

      expect(response.body).to eq(counties_arr.to_json)
    end
  end
end
