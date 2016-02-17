class Api::V1::CategoriesController < ApplicationController

  def index
    categories = Category.all
    render json: categories
  end

  def show
    category = Category.find(params[:id])
    render json: category
  end

  def create
    category = Category.new(category_params)

    if category.save
      render json: category, status: 201, location: [:api, category]
    else
      render json: { errors: category.errors }, status: 422
    end
  end

  def update
    category = Category.find(params[:id])

    if category.update(category_params)
      render json: category, status: 200, location: [:api, category]
    else
      render json: { errors: category.errors }, status: 422
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    head 204
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
