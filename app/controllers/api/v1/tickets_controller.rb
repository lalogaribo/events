class Api::V1::TicketsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_ticket, only: [:show, :update, :destroy]

  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  def show
    render json: @ticket
  end

  def create
    event = Event.find(params[:event_id])
    @ticket = @cart.add_ticket(event)
    if @ticket.save
      render json: @ticket, status: 200
    else
      render json: @ticket.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: @ticket.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:event_id, :cart_id)
    end
end
