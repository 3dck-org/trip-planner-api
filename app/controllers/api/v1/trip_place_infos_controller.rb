class Api::V1::TripPlaceInfosController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_trip_place_info, only: %i[ show update destroy ]

  # GET /trip_place_infos
  def index
    @trip_place_infos = TripPlaceInfo.all

    render json: @trip_place_infos
  end

  # GET /trip_place_infos/1
  def show
    render json: @trip_place_info
  end

  # POST /trip_place_infos
  def create
    @trip_place_info = TripPlaceInfo.new(trip_place_info_params)

    if @trip_place_info.save
      render json: @trip_place_info, status: :created
    else
      render json: { error_message: @trip_place_info.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trip_place_infos/1
  def update
    if @trip_place_info.update(trip_place_info_params)
      render json: @trip_place_info
    else
      render json: { error_message: @trip_place_info.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  # DELETE /trip_place_infos/1
  def destroy
    @trip_place_info.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_place_info
      @trip_place_info = TripPlaceInfo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_place_info_params
      params.require(:trip_place_info).permit(:trip_id, :place_id, :comment, :order)
    end
end
