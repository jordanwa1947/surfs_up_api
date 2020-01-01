class Api::V1::SurfController < ApplicationController

  def show
    spot = Spot.find_by(spot_id: params['spot_id'])
    facade = MswFacade.new(params['spot_id'], spot)
    forecast = facade.forecast
    render json: ForecastSerializer.new(forecast).serializable_hash
  end
end
