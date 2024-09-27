# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateGeolocation' do
  describe '.call' do
    context 'when no errors' do
      it 'creates a new geolocation' do
        network_address = 'www.example.com'

        expected_response = {
          'ip' => '3.167.99.122',
          'type' => 'ipv4',
          'continent_code' => 'NA',
          'continent_name' => 'North America',
          'country_code' => 'US'
        }

        allow(IpStack::Api::FetchGeolocation)
          .to receive(:call)
          .with(network_address:)
          .and_return(expected_response)

        geolocation = CreateGeolocation.call(network_address:)

        expect(geolocation).to be_a(Geolocation)
        expect(geolocation.response).to eq(expected_response)
        expect(geolocation.network_address).to eq(network_address)
        expect(Geolocation.count).to eq(1)
      end

      context 'when geolocation already exists' do
        it 'does not create a new geolocation' do
          network_address = 'www.example.com'
          create(:geolocation, network_address:)

          allow(IpStack::Api::FetchGeolocation)
            .to receive(:call)
            .with(network_address:)
            .and_return({ data: 'data' }.to_json)

          expect { CreateGeolocation.call(network_address:) }.not_to change(Geolocation, :count)
        end

        it 'returns the existing geolocation' do
          network_address = 'www.example.com'
          geolocation = create(:geolocation, network_address:)

          allow(IpStack::Api::FetchGeolocation)
            .to receive(:call)
            .with(network_address:)
            .and_return({ data: 'data' }.to_json)

          expect(CreateGeolocation.call(network_address:)).to eq(geolocation)
        end
      end
    end

    context 'when error occurs' do
      it 'does not create a new geolocation' do
        network_address = 'www.example.com'

        allow(IpStack::Api::FetchGeolocation)
          .to receive(:call)
          .with(network_address:)
          .and_raise(IpStack::Api::Error)

        expect { CreateGeolocation.call(network_address:) }.to raise_error(IpStack::Api::Error)
        expect(Geolocation.count).to eq(0)
      end
    end
  end
end
