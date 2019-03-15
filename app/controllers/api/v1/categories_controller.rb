class Api::V1::CategoriesController < ApplicationController
  before_action :find_category, only: %i[destroy show update]

  def index
    @categories = Category.all
    render :index, status: 200
  end

  def show
    render :show, status: 200
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render :create, status: 200
    else
      render json: @category.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render :update, status: 200
    else
      render json: @category.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      render json: @category, status: 200
    else
      head(:unprocessable_entity)
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: e, status: 404
    end
end
