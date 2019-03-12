class Api::V1::CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :non_existing_cart

  def index
    @carts = Cart.all
    render json: @carts
  end

  def show
    render json: @cart
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.fetch(:cart, {})
  end

  def non_existing_cart
    logger.error "Invalid cart #{params[:id]}"
    render json: 'Invalid cart', status: 404
  end
end
