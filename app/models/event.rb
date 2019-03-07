class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, :address, :description, presence: true,
                    length: { minimum: 5, maximum: 255 }
	validates :category_id, presence: true
end