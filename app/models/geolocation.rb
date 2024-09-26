# frozen_string_literal: true

class Geolocation < ApplicationRecord
  validates :network_address, presence: true, uniqueness: true
  validates :response, presence: true
end
