require 'rails_helper'

describe NewsItem, type: :model do 
  describe 'find_for' do
    it 'finds a news item for the given representative' do
      rep = double('Joe Biden', id: 1)
      news_item = NewsItem.create(representative_id: rep.id)
      allow(NewsItem).to receive(:find_by).with(representative_id: rep.id).and_return(news_item)

      expect(NewsItem.find_for(rep.id).representative_id).to eq(rep.id)
    end 
  end 
end