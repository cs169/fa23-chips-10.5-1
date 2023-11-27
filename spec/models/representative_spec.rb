# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Representative do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      OpenStruct.new(
        officials: [OpenStruct.new(name: 'John Doe')],
        offices:   [OpenStruct.new(name: 'Office', official_indices: [0], division_id: 'ocdid')]
      )
    end

    it 'creates a new rep if one does not exist' do
      expect { described_class.civic_api_to_representative_params(rep_info) }.to change(described_class, :count).by(1)
      rep = described_class.last
      expect(rep.name).to eq('John Doe')
      expect(rep.title).to eq('Office')
      expect(rep.ocdid).to eq('ocdid')
    end

    it 'does not create a new rep if one already exists' do
      described_class.create!(name: 'John Doe', ocdid: 'ocdid', title: 'Office')
      expect { described_class.civic_api_to_representative_params(rep_info) }.not_to change(described_class, :count)
    end
  end
end
