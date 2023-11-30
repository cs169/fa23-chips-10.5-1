# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      formatted_address = 'No address found'
      unless official.address.nil?
        civic_address = official.address[0]
        formatted_address = "#{civic_address.line1}, #{civic_address.city}, #{civic_address.state} #{civic_address.zip}"
      end

      # Check if any rep w/ the given name exists first and update it w/ new data, otherwise create new
      rep_data = { name: official.name, ocdid: ocdid_temp, title: title_temp,
                  photo: official.photo_url, party: official.party, address: formatted_address }

      existing_rep = Representative.find_or_initialize_by(name: official.name)
      rep = if existing_rep.persisted?
              existing_rep.update(rep_data)
            else
              Representative.create(rep_data)
            end
      reps.push(rep)
    end
    reps
  end
end
