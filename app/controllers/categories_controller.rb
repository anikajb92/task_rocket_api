class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    render json: @categories, status: :ok
  end 

  def create
    @new_category = Category.new name: params[:name]

    if @new_category.valid?
      @new_category.save
      render json: @new_category, status: :created
    else
      render json: { errors: @new_category.errors.full_messages}, status: :unprocessable_entity
    end
  end 
end
