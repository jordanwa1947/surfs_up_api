class Api::V1::SearchController < ApplicationController

  def index
    render json: SpotSerializer.new(Spot.search(params[:query]))
  end
end
