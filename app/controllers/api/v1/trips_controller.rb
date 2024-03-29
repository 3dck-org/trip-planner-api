class Api::V1::TripsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_trip, only: %i[ show update destroy add_to_favorite remove_from_favorite]

  # GET /api/v1/trips
  def index
    @trips = Trip.all

    options = {}
    if params[:favorite_only] == 'true'
      options[:id] = UserFavoriteTrip.where(user_id: doorkeeper_token.resource_owner_id).distinct.pluck(:trip_id)
    end

    if params[:city].present?
      address_ids = Address.where(city: params[:city]).ids
      trip_ids = Place.where(address_id: address_ids).map(&:trips).flatten.uniq.pluck(:id)
      @trips = Trip.where(id: trip_ids)
      append_options(options, :id, trip_ids)
    end

    if params[:category_names].present?
      options[:id] = nil
      filtered_category_names = params[:category_names].split(',').map { |name| name.downcase.gsub(' ', '_') }
      place_ids = CategoryDictionary.where(name: filtered_category_names).map(&:places).flatten.uniq.pluck(:id)
      if place_ids.present?
        trip_ids = Place.where(id: place_ids).map(&:trips).flatten.uniq.pluck(:id)
        if trip_ids.present?
          append_options(options, :id, trip_ids.uniq)
        end
      end
    end

    if params[:x].present? && params[:y].present? && params[:radius].present?
      current_location = Geokit::LatLng.new(params[:x], params[:y])
      filtered_places = []
      Trip.all.map(&:places).flatten.uniq.each do |place|
        place_coords = "#{place.point.x},#{place.point.y}"
        filtered_places << place if (current_location.distance_to(place_coords) * 1000) <= params[:radius].to_i
      end
      trip_ids = filtered_places.map(&:trips).flatten.uniq.pluck(:id)
      append_options(options, :id, trip_ids)
    end

    if options.present?
      @trips = @trips.where(options)
    end

    # Always add current journey trip to the result
    current_journey = Journey.find_by(completed: false, user_id: doorkeeper_token.resource_owner_id)
    if current_journey && !@trips.include?(current_journey.trip)
      @trips = Trip.where(id: current_journey.trip_id) + @trips
    end

    Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
    render json: @trips,
           include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } },
           methods: [:favorite, :average_rating]
  end

  # GET /api/v1/trips/1
  def show
    Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
    render json: @trip,
           include: [{ trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } }, :user],
           methods: [:favorite, :average_rating]
  end

  def filter_data
    categories_data = []
    categories = Place.all.map(&:category_dictionaries).flatten.uniq
    categories.each do |category|
      categories_data << { code: category.name, name: category.name.gsub('_', ' ').capitalize }
    end
    cities = Address.where(id: Place.all.distinct.pluck(:address_id)).distinct.pluck(:city).compact
    render json: { categories: categories_data, cities: cities }
  end

  # POST /api/v1/trips
  def create
    @trip = Trip.new(trip_params.except(:places))
    @trip.user_id = doorkeeper_token.resource_owner_id
    if @trip.save!
      params[:trip][:places].each_with_index do |place, index|
        address = Address.new
        address.country = 'Poland'
        address.city = place[:city]
        address.street = place[:street]
        address.save!

        new_place = Place.new
        new_place.address_id = address.id
        new_place.name = place[:name]
        new_place.description = place[:description]
        new_place.google_maps_url = place[:google_maps_url]
        begin
          coords = place[:point].split(',')
          point = ActiveRecord::Point.new(coords[0], coords[1])
          new_place.point = point
        rescue StandardError => e
          render json: "Erorr with point generation for coords: #{place[:point]}. #{e.message}",
                 status: :unprocessable_entity
        end

        category_names = place[:category_names]
        if category_names
          category_names.each do |name|
            category = CategoryDictionary.find_by(name: name)
            if category
              new_place.category_dictionaries << category
            end
          end
        end

        if new_place.save!
          TripPlaceInfo.create!(place_id: new_place.id, trip_id: @trip.id, order: index + 1, comment: place[:description])
        else
          render json: { error_message: new_place.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
        end
      end

      Trip.current_user = User.find(doorkeeper_token.resource_owner_id)
      render json: @trip, status: :created,
             include: { trip_place_infos: { include: { place: { include: [:address, :category_dictionaries] } } } },
             methods: [:favorite, :average_rating]
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
             methods: [:favorite, :average_rating]
    else
      render json: { error_message: @trip.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trips/1
  def destroy
    @trip.destroy
  end

  private

  def append_options(options, key, value)
    if options[key]
      options[key] = options[key] & value
    else
      options[key] = value
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trip_params
    params.require(:trip).permit(:name, :description, :distance, :duration, :user_id, :image_url, :favorite, :places)
  end
end
