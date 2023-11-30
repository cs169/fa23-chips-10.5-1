# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:state) { create(:state) }
  let(:county) { create(:county, state: state) }
  let(:event) { create(:event, county: county) }

  describe 'GET #index' do
    context 'when filter-by param is not present' do
      it 'assigns all events to @events' do
        get :index
        expect(assigns(:events)).to eq(Event.all)
      end
    end

    context 'when filter-by param is present' do
      it 'assigns filtered events to @events' do
        get :index, params: { 'filter-by': 'state-only', state: state.symbol }
        expect(assigns(:events)).to eq(Event.where(county: state.counties))
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event to @event' do
      get :show, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end
end
