class Cart < ApplicationRecord
	has_many :tickets, dependent: :destroy

	def add_ticket(event)
		current_event = tickets.find_by(event_id: event.id)
		if current_event
			current_event.quantity += 1
		else
			current_event = tickets.build(event_id: event.id)
		end
		current_event
	end
end
