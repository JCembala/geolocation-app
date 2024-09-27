# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Geolocations' do
  describe '.call' do
    context 'when no errors' do
      it 'makes a request to the IpStack API' do
        network_address = 'www.example.com'
        access_key = 'access_key'

        expected_response = {
          'ip' => '134.201.250.155',
          'hostname' => '134.201.250.155',
          'type' => 'ipv4',
          'continent_code' => 'NA',
          'continent_name' => 'North America',
          'country_code' => 'US'
        }

        allow(ENV)
          .to receive(:fetch)
          .with('IPSTACK_API_KEY')
          .and_return(access_key)

        stub_request(:get, "http://api.ipstack.com/#{network_address}?access_key=#{access_key}")
          .to_return(status: 200, body: expected_response.to_json)

        response = IpStack::Api::FetchGeolocation.call(network_address:)

        expect(response).to eq(expected_response)
      end
    end

    context 'when error occurs' do
      it 'raises an error' do
        network_address = 'www.example.com'
        access_key = 'access'

        response = {
          'error' => {
            'code' => 101,
            'type' => 'invalid_network_address',
            'info' => 'You have entered an invalid network address. Please try again.'
          }
        }

        expected_error = {
          'HttpStatus' => 101,
          'Type' => 'invalid_network_address',
          'Info' => 'You have entered an invalid network address. Please try again.'
        }

        allow(ENV)
          .to receive(:fetch)
          .with('IPSTACK_API_KEY')
          .and_return(access_key)

        stub_request(:get, "http://api.ipstack.com/#{network_address}?access_key=#{access_key}")
          .to_return(status: 101, body: response.to_json)

        expect do
          IpStack::Api::FetchGeolocation.call(network_address:)
        end.to raise_error(IpStack::Api::Error, expected_error.to_json)
      end

      context 'when server is unavailable' do
        it 'raises unknown error' do
          network_address = 'www.example.com'
          access_key = 'access_key'

          expected_error = {
            'HttpStatus' => 500,
            'Type' => 'unknown_error',
            'Info' => 'An unknown error occurred.'
          }

          allow(ENV)
            .to receive(:fetch)
            .with('IPSTACK_API_KEY')
            .and_return(access_key)

          stub_request(:get, "http://api.ipstack.com/#{network_address}?access_key=#{access_key}")
            .to_return(status: 500, body: '{}')

          expect do
            IpStack::Api::FetchGeolocation.call(network_address:)
          end.to raise_error(IpStack::Api::Error, expected_error.to_json)
        end
      end

      context 'when response is invalid' do
        it 'raises an error' do
          network_address = 'www.example.com'
          access_key = 'access'

          allow(ENV)
            .to receive(:fetch)
            .with('IPSTACK_API_KEY')
            .and_return(access_key)

          allow(JSON).to receive(:parse).and_raise(JSON::ParserError)

          stub_request(:get, "http://api.ipstack.com/#{network_address}?access_key=#{access_key}")
            .to_return(status: 200, body: 'invalid response')

          expect do
            IpStack::Api::FetchGeolocation.call(network_address:)
          end.to raise_error(IpStack::Api::Error, 'Invalid response from IpStack API.')
        end
      end
    end
  end
end
