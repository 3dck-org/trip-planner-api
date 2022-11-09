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
      render json: { error_message: @trip.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/trips/1
  def update
    Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
    favorite = trip_params[:favorite]
    uft_options = { trip_id: @trip.id, user_id: doorkeeper_token.resource_owner_id }
    uft = UserFavoriteTrip.find_by(uft_options)
    if favorite == 'true' || favorite == true
      UserFavoriteTrip.where(uft_options).first_or_create unless uft.present?
    elsif favorite == 'false' || favorite == false
      uft.destroy if uft.present?
    end

    if @trip.update(trip_params.except(:favorite))
      render json: @trip,
             include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } },
             methods: [:favorite]
    else
      render json: { error_message: @trip.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
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
    params.require(:trip).permit(:name, :description, :distance, :duration, :user_id, :image_url, :favorite)
  end
end
