class  Api::V1::AddressesController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_address, only: %i[ show update destroy ]

  # GET /addresses
  def index
    @addresses = Address.all

    render json: @addresses
  end

  # GET /addresses/1
  def show
    render json: @address
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)

    if @address.save
      render json: @address, status: :created
    else
      render json: { error_message: @address.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: { error_message: @address.errors.full_messages, error_code: 422 }, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:country, :city, :street, :buildingNumber, :apartment, :postalCode)
  end
end
