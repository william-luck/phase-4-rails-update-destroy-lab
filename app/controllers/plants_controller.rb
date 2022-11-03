class PlantsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant
  end

  def destroy
    find_plant.destroy
    head :no_content
  end

  private

  def find_plant
    Plant.find(params[:id])
  end

  def not_found_error
    render json: {erorr: 'Plant not found'}, status: :not_found
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end
