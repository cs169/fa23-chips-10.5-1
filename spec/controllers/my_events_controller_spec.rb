# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User factory
  let(:event) { create(:event) } # Assuming you have an Event factory

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    it 'assigns a new Event to @event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested Event to @event' do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Event' do
        expect do
          post :create, params: { event: attributes_for(:event) }
        end.to change(Event, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new Event' do
        expect do
          post :create, params: { event: attributes_for(:event, name: nil) }
        end.not_to change(Event, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the Event' do
        patch :update, params: { id: event.id, event: { name: 'New Name' } }
        event.reload
        expect(event.name).to eq('New Name')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the Event' do
        patch :update, params: { id: event.id, event: { name: nil } }
        event.reload
        expect(event.name).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the Event' do
      event
      expect do
        delete :destroy, params: { id: event.id }
      end.to change(Event, :count).by(-1)
    end
  end
end
