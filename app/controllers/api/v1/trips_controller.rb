class Api::V1::TripsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_trip, only: %i[ show update destroy add_to_favorite remove_from_favorite]

  # GET /api/v1/trips
  def index
    if params[:favorite_only] == 'true'
      @trips = Trip.where(id: UserFavoriteTrip.where(user_id: doorkeeper_token.resource_owner_id).distinct.pluck(:trip_id))
    else
      @trips = Trip.all
    end

    Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
    render json: @trips,
           include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } },
           methods: [:favorite]
  end

  # GET /api/v1/trips/1
  def show
    Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
    render json: @trip,
           include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } },
           methods: [:favorite]
  end

  # POST /api/v1/trips
  def create
    @trip = Trip.new(trip_params)
    Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
    if @trip.save
      render json: @trip, status: :created,
             include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } },
             methods: [:favorite]
    else
      render json: { error: @trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/trips/1
  def update
    Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
    if @trip.update(trip_params)
      render json: @trip,
             include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } },
             methods: [:favorite]
    else
      render json: { error: @trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trips/1
  def destroy
    @trip.destroy
  end

  def add_to_favorite
    UserFavoriteTrip.where(trip_id: @trip.id, user_id: doorkeeper_token.resource_owner_id).first_or_create

    render json: { success: true }
  end

  def remove_from_favorite
    uft = UserFavoriteTrip.where(trip_id: @trip.id, user_id: doorkeeper_token.resource_owner_id).first

    if uft
      uft.destroy
      render json: { success: true }
    else
      render json: { error: "Trip #{@trip.id} was not added to favorite by user #{doorkeeper_token.resource_owner_id}" }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trip_params
    params.require(:trip).permit(:name, :description, :distance, :duration, :user_id, :image_url)
  end
end
