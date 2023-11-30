# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative: representative) }

  describe 'GET #index' do
    it 'assigns all news items of the representative to @news_items' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq(representative.news_items)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested news item to @news_item' do
      get :show, params: { id: news_item.id, representative_id: representative.id }
      expect(assigns(:news_item)).to eq(news_item)
    end
  end
end
