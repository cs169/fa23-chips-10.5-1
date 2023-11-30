# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe RepresentativesController, type: :controller do
  describe 'show' do
    let(:representative) { instance_double(Representative, id: 1, address: '123 Main St') }

    before do
      allow(Representative).to receive(:find).with(representative.id.to_s).and_return(representative)
    end

    it 'finds the representative with the correct id' do
      get :show, params: { id: representative.id }
      expect(assigns(:representative)).to eq(representative)
    end

    it 'assigns the representative address' do
      get :show, params: { id: representative.id }
      expect(assigns(:address)).to eq(representative.address)
    end

    it 'renders the show template' do
      get :show, params: { id: representative.id }
      expect(response).to render_template('show')
    end
  end
end
