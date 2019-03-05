class Event < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { minimum: 5, maximum: 255 }
  validates :address, presence: true, length: { minimum: 5, maximum: 255 }
  validates :description, presence: true, length: { minimum: 5, maximum: 255 }
end