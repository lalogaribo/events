class Event < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :tickets

	before_destroy :event_dont_have_tickets

	validates :name, :address, :description, presence: true,
						length: {minimum: 5, maximum: 255}
	validates :category_id, presence: true

	private

	def event_dont_have_tickets
		unless tickets.empty?
			errors.add(:base, 'This event already sold tickets ')
			throw :abort
		end
	end
end