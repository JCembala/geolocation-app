class GeolocationsController < ApplicationController
  before_action :set_geolocation, only: %i[show destroy]

  def create
    geolocation = CreateGeolocation.call(network_address: params[:network_address])

    render json: geolocation, status: :created

  rescue IpStack::Api::Error => e
    render json: { error: e.message }, status: :bad_request
  end

  def show
    render json: @geolocation
  end

  def destroy
    @geolocation.destroy

    render json: { message: 'Successfully deleted geolocation' }
  end

  private

  def set_geolocation
    @geolocation = Geolocation.find(params[:id])
  end

  def permitted_params
    params.permit(:network_address)
  end
end
