class Api::V1::PlacesController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_place, only: %i[ show update destroy ]

  # GET /places
  def index
    @places = Place.all

    render json: @places, include: :category_dictionaries
  end

  # GET /places/1
  def show
    render json: @place, include: :category_dictionaries
  end

  # POST /places
  def create
    @place = Place.new(place_params.except(:category_names))

    category_names = params[:place][:category_names]
    if category_names
      category_names.each do |name|
        category = CategoryDictionary.where(name: name).first_or_create!
        @place.category_dictionaries << category
      end
    end

    begin
      coords = place_params[:point].split(',')
      point = ActiveRecord::Point.new(coords[0], coords[1])
      @place.point = point
    rescue StandardError => e
      render json: "Erorr with point generation for coords: #{place_params[:point]}. #{e.message}",
             status: :unprocessable_entity
    end

    if @place.save
      render json: @place, include: :category_dictionaries, status: :created
    else
      render json: { error: @place.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    category_names = params[:place][:category_names]
    new_category_dictionaries = []
    if category_names
      category_names.each do |name|
        category = CategoryDictionary.where(name: name).first_or_create!
        new_category_dictionaries << category
      end
    end

    begin
      coords = place_params[:point].split(',')
      point = ActiveRecord::Point.new(coords[0], coords[1])
      @place.point = point
    rescue StandardError => e
      render json: { error: ["Error with point generation for coords: #{place_params[:point]}. #{e.message}"] },
             status: :unprocessable_entity
    end

    @place.category_dictionaries = new_category_dictionaries
    @place.save!

    if @place.update(place_params.except(:category_names))
      render json: @place, include: :category_dictionaries
    else
      render json: { error: @place.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_place
    @place = Place.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def place_params
    params.require(:place).permit(:name, :description, :address_id, :point, :category_names)
  end
end
