class Api::V1::EventsController < ApplicationController
	before_action :find_event, only: [:update, :show, :destroy]

	def index
		if params.has_key?(:category_id)
			events = Event.where(category_id: params[:category_id])
		else
			events = Event.all
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
			params.require(:event).permit(:name, :description, :address, :category_id, :user_id)
		end

		def find_event
			@event = Event.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		end
end 