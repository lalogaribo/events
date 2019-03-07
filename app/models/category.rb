class Category < ApplicationRecord
	has_many :events
	validates :name, presence: true, length: { maximum: 255 }
end
