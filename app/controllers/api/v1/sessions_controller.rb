class Api::V1::SessionsController < ApplicationController

  def show
    current_user ? head(:ok) : head(:unauthorized)
  end
  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.valid_password?(params[:password])
      render :create, status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    current_user && authentication_token = nil
    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
end