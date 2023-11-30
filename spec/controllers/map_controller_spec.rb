# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  let(:state) { create(:state) }
  let(:county) { create(:county, state: state) }

  describe 'GET #index' do
    it 'assigns all states to @states' do
      get :index
      expect(assigns(:states)).to eq(State.all)
    end
  end

  describe 'GET #state' do
    context 'when state exists' do
      it 'assigns the requested state to @state' do
        get :state, params: { state_symbol: state.symbol }
        expect(assigns(:state)).to eq(state)
      end
    end

    context 'when state does not exist' do
      it 'redirects to root path with an alert message' do
        get :state, params: { state_symbol: 'ZZ' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("State 'ZZ' not found.")
      end
    end
  end

  describe 'GET #county' do
    context 'when county exists' do
      it 'assigns the requested county to @county' do
        get :county, params: { state_symbol: state.symbol, std_fips_code: county.fips_code }
        expect(assigns(:county)).to eq(county)
      end
    end

    context 'when county does not exist' do
      it 'redirects to root path with an alert message' do
        get :county, params: { state_symbol: state.symbol, std_fips_code: '999' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("County with code '999' not found for #{state.symbol}")
      end
    end
  end
end
