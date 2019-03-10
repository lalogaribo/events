class Api::V1::EventsController < ApplicationController
  before_action :find_event, only: %i[update show destroy]

  def index
    events = if params.key?(:category_id)
               Event.where(category_id: params[:category_id])
             else
               Event.all
             end
    render json: events
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: event
    else
      render json: event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @event.update(event_params)
    if @event.save
      render json: @event, status: :ok
    else
      render json: @event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: @event, status: 200
  end

  def destroy
    if @event.destroy
      render json: @event, status: :ok
    else
      render json @event.errors.full_messages, status: :not_found
    end
  end

  private

  def event_params
		params.require(:event).permit(:name, :description, :address,
																	:category_id, :user_id, :quantity)
  end

  def find_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: e, status: 404
  end
end
