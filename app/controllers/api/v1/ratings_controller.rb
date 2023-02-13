class Api::V1::RatingsController < ApplicationController
  before_action :doorkeeper_authorize!

  def create
    @rating = Rating.new(rating_params)
    @rating.user_id = doorkeeper_token.resource_owner_id

    if @rating.save
      render json: @rating, status: :created
    else
      render json: { error_message: @rating.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:trip_id, :grade)
  end
end
