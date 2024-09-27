# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  describe 'validations' do
    it 'validates presence of network_address' do
      expect(subject).to validate_presence_of(:network_address)
    end

    it 'validates presence of response' do
      expect(subject).to validate_presence_of(:response)
    end

    it 'validates uniqueness of network_address' do
      create(:geolocation, network_address: 'existing_address')
      expect(subject).to validate_uniqueness_of(:network_address)
    end
  end

  describe 'columns' do
    it 'has network_address column of type string' do
      expect(subject).to have_db_column(:network_address).of_type(:string)
    end

    it 'has response column of type json' do
      expect(subject).to have_db_column(:response).of_type(:json)
    end
  end
end
