class Api::V1::SearchController < ApplicationController

  def index
    spot = Spot.search(params[:query])
    render json: SpotSerializer.new(spot).serializable_hash
  end
end
