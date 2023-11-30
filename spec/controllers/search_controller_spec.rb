# frozen_string_literal: true

describe SearchController do
  describe 'search' do
    # it 'renders search if result not nil' do
    #   allow_any_instance_of(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:representative_info_by_address).and_return('Some result')
    #   get :search, params: { address: 'Valid address' }
    #   expect(response).to render_template('representatives/search')
    # end

    it 'renders index if result nil' do
      allow_any_instance_of(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:representative_info_by_address).and_return(nil)
      get :search, params: { address: 'Some other invalid address' }
      expect(response).to render_template('representatives/index')
    end
  end
end
