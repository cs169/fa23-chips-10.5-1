# frozen_string_literal: true
require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @representative = Representative.find(params[:representative_id])
    @issue = params[:issue]
    @news_item = NewsItem.new

    newsapi = News.new(Rails.application.credentials.dig(:production, :NEWS_API_KEY)) 
    @articles = newsapi.get_everything(q: @representative.name, sources: 'bbc-news,google-news', language: 'en', country: 'us', sortBy: 'relevancy', pageSize: 5)
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def search_my_news_item
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
    @issues = NewsItem::ISSUES

    redirect_to representative_new_my_news_item_path(@representative)
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id)
  end

end
