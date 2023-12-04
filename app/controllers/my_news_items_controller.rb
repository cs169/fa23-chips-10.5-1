# frozen_string_literal: true
require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new

    @representative = Representative.find(params[:representative_id])

    # @representatives = Representative.all
    # @issues = NewsItem::ISSUES

    newsapi = News.new(Rails.application.credentials.dig(:production, :GOOGLE_NEWS_API_KEY)) 
    response = newsapi.get_everything(q: "#{@representative.name} #{@issue}", sources: 'bbc-news,google-news', language: 'en', pageSize: 5)
    
    # Check if the request was successful
    # if response.status == 'ok'
    #   # These will be used in the view to build the radio buttons
    #   @articles = response.articles
    # else
    #   # If the request was not successful, you might want to redirect the user back to the form and display an error message
    #   redirect_to new_representative_my_news_item_path(@representative), alert: 'There was an error fetching the news articles. Please try again.'
    # end
    puts response 
    if response.empty?
      redirect_to representative_search_my_news_item_path(@representative), alert: 'There was an error fetching the news articles. Please try again.'
    else
      @articles = response
    end
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

  def search
    if request.get?
      @representatives = Representative.all
      @issues = NewsItem::ISSUES.map.with_index(1) do |issue, index|
        OpenStruct.new(id: index, name: issue)
      end
    elsif request.post?
      redirect_to representative_new_my_news_item_path(representative_id: params[:representative_id], issue_id: params[:issue_id])
    end
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
