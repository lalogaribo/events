module Api::V1
  class UsersController < ApplicationController
    before_action :find_user, only: [:show, :update, :destroy]

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    end

    def show
      render json: @user, status: :ok
    end

    def destroy
      if @user.destroy
        render json: @user, status: :ok
      else
        render status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password,
                                   :password_confirmation,
                                   :first_name, :last_name, :phone_number)
    end

    def find_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: e, status: 404
    end
  end
end