# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Geolocations', type: :request do
  describe 'POST /create' do
    context 'when no errors' do
      it 'returns created status' do
        geolocation = create(:geolocation)
        params = { network_address: 'www.example.com' }

        allow(CreateGeolocation).to receive(:call).and_return(geolocation)

        post('/geolocations', params:)

        expect(response).to have_http_status(:created)
      end

      it 'returns geolocation data as json' do
        geolocation = create(:geolocation)
        params = { network_address: 'www.example.com' }

        allow(CreateGeolocation).to receive(:call).and_return(geolocation)

        post('/geolocations', params:)

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq(Geolocation.last.to_json)
      end
    end

    context 'when error occurs' do
      it 'returns bad request status' do
        params = { network_address: 'www.example.com' }

        allow(CreateGeolocation).to receive(:call).and_raise(IpStack::Api::Error)

        post('/geolocations', params:)

        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message as json' do
        params = { network_address: 'www.example.com' }

        allow(CreateGeolocation).to receive(:call).and_raise(IpStack::Api::Error, 'Error message')

        post('/geolocations', params:)

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq({ error: 'Error message' }.to_json)
      end
    end
  end

  describe 'GET /show' do
    context 'when no errors' do
      it 'returns ok status' do
        geolocation = create(:geolocation)

        get("/geolocations/#{geolocation.id}")

        expect(response).to have_http_status(:ok)
      end

      it 'returns geolocation data as json' do
        geolocation = create(:geolocation)

        get("/geolocations/#{geolocation.id}")

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq(geolocation.to_json)
      end
    end

    context 'when record not found' do
      it 'returns not found status' do
        get('/geolocations/0')

        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message as json' do
        get('/geolocations/0')

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq({ error: 'Record not found' }.to_json)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when no errors' do
      it 'returns ok status' do
        geolocation = create(:geolocation)

        delete("/geolocations/#{geolocation.id}")

        expect(response).to have_http_status(:ok)
      end

      it 'deletes the record' do
        geolocation = create(:geolocation)

        delete("/geolocations/#{geolocation.id}")

        expect(Geolocation.count).to eq(0)
      end

      it 'returns success message as json' do
        geolocation = create(:geolocation)

        delete("/geolocations/#{geolocation.id}")

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq({ message: 'Successfully deleted geolocation' }.to_json)
      end
    end

    context 'when record not found' do
      it 'returns not found status' do
        delete('/geolocations/0')

        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message as json' do
        delete('/geolocations/0')

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq({ error: 'Record not found' }.to_json)
      end
    end
  end
end
