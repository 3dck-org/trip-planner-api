class Api::V1::TripsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_trip, only: %i[ show update destroy ]

  # GET /api/v1/trips
  def index
    @trips = Trip.all

    render json: @trips
  end

  # GET /api/v1/trips/1
  def show
    render json: @trip
  end

  # POST /api/v1/trips
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      render json: @trip, status: :created
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/trips/1
  def update
    if @trip.update(trip_params)
      render json: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trips/1
  def destroy
    @trip.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trip_params
    params.require(:trip).permit(:name, :description, :distance, :duration, :user_id)
  end
end
