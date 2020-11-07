class Api::V1::GoogleStoresController < ApplicationController
  def index
    render json: GoogleListCoffeeService.new(params[:latitude].to_f, params[:longitude].to_f).call
  end

  def show
    render json: GoogleDetailsCoffeeService.new(params[:id]).call
  end
end
