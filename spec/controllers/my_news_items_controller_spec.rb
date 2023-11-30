# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User factory
  let(:representative) { create(:representative) } # Assuming you have a Representative factory
  let(:news_item) { create(:news_item, representative: representative) } # Assuming you have a NewsItem factory

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    it 'assigns a new NewsItem to @news_item' do
      get :new, params: { representative_id: representative.id }
      expect(assigns(:news_item)).to be_a_new(NewsItem)
    end
  end

  # Add similar tests for #edit, #create, #update, and #destroy
  describe 'GET #edit' do
    it 'assigns the requested NewsItem to @news_item' do
      get :edit, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new NewsItem' do
        expect do
          post :create, params: { representative_id: representative.id, news_item: attributes_for(:news_item) }
        end.to change(NewsItem, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new NewsItem' do
        expect do
          post :create,
               params: { representative_id: representative.id, news_item: attributes_for(:news_item, title: nil) }
        end.not_to change(NewsItem, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the NewsItem' do
        patch :update,
              params: { representative_id: representative.id, id: news_item.id, news_item: { title: 'New Title' } }
        news_item.reload
        expect(news_item.title).to eq('New Title')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the NewsItem' do
        patch :update, params: { representative_id: representative.id, id: news_item.id, news_item: { title: nil } }
        news_item.reload
        expect(news_item.title).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the NewsItem' do
      news_item
      expect do
        delete :destroy, params: { representative_id: representative.id, id: news_item.id }
      end.to change(NewsItem, :count).by(-1)
    end
  end
end
