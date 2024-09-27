# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'IpStack::Api::Error' do
  it 'inherits from StandardError' do
    expect(IpStack::Api::Error.ancestors).to include(StandardError)
  end
end
