# frozen_string_literal: true
require 'open-uri'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new

    @ratings = [1, 2, 3, 4, 5]
    @issues = NewsItem::ISSUES

    @representative = Representative.find(params[:representative_id])
    @issue = NewsItem::ISSUES[params[:issue_id].to_i - 1]
    @search_rep = Representative.find(params[:search_id])

    # uri = URI('https://newsapi.org/v2/everything')
    # params = {
    #   q: "#{@representative.name} #{@issue}",
    #   sources: 'bbc-news,the-verge',
    #   language: 'en',
    #   apiKey: Rails.application.credentials.dig(:production, :GOOGLE_NEWS_API_KEY),
    #   pageSize: 5
    # }
    url = "https://newsapi.org/v2/everything?q=#{URI.encode(@search_rep.name + ' AND ' + @issue)}&sortBy=popularity&apiKey=#{Rails.application.credentials.dig(:production, :GOOGLE_NEWS_API_KEY)}&pageSize=5"
    
    begin
      response = open(url).read
      result = JSON.parse(response)
      @articles = result['articles']
    rescue OpenURI::HTTPError => e
      redirect_to representative_search_my_news_item_path(@representative), alert: 'There was an error fetching the news articles. Please try again.'
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
      redirect_to representative_new_my_news_item_path(representative_id: params[:representative_id], issue_id: params[:issue_id], search_id: params[:reps_id])
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
