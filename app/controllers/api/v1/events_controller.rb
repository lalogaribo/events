class Api::V1::EventsController < ApplicationController
  def index
    if params.has_key?(:category_id)
      events = Event.where(category_id: params[:category_id])
    else
      events =  Event.all
    end
    render json: events
  end

  def new; end

  def create
    event = Event.new(event_params)
    event.user = current_user
    if event.save
      render json: event
    else
      render json: event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    event = Event.find(params[:id])
    event.update(event_params)
    if event.save
      render json: event, status: :ok
    else
      render json: event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Event.find(params[:id]), status: 200
  end

  def destroy
    event = Event.find(params[:id])
    if event.destroy
      render json: event, status: :ok
    else
      render json event.errors.full_messages, status: :not_found
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :address, :category_id)
  end
end 