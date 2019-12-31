class Api::V1::SpotsController < ApplicationController

  def index
    render json: SpotSerializer.new(Spot.all)
  end
end
