class Api::V1::JourneysController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_journey, only: %i[ show update destroy ]

  # GET /journeys
  def index
    @journeys = Journey.where(user_id: doorkeeper_token.resource_owner_id)

    render json: @journeys, include: :journey_place_infos
  end

  # GET /journeys/1
  def show
    render json: @journey, include: :journey_place_infos
  end

  def current_journey
    @journey = Journey.find_by(user_id: doorkeeper_token.resource_owner_id, completed: false)

    render json: @journey, include: [{ trip: { include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries], methods: :google_maps_url } } } }, methods: [:favorite] } }, :user, :journey_place_infos]
  end

  # POST /journeys
  def create
    @journey = Journey.new(journey_params)
    if @journey.start_at.nil?
      @journey.start_at = DateTime.now
    end
    @journey.user_id = doorkeeper_token.resource_owner_id

    if @journey.save!
      @journey.trip.places.each do |p|
        JourneyPlaceInfo.create!(journey_id: @journey.id, place_id: p.id)
      end
      render json: @journey, include: :journey_place_infos, status: :created
    else
      render json: { error_message: @journey.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /journeys/1
  def update
    if @journey.update!(journey_params)
      render json: @journey, include: :journey_place_infos
    else
      render json: { error_message: @journey.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  def update_place_status
    journey = Journey.find(params[:journey_id])
    jpi = JourneyPlaceInfo.find_by(journey_id: journey.id, place_id: params[:place_id])
    if jpi.update(status: params[:status])
      render json: jpi
    else
      render json: { error_message: jpi.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  private

  def set_journey
    @journey = Journey.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def journey_params
    params.require(:journey).permit(:distance, :start_at, :end_at, :completed, :trip_id)
  end
end
