class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :measurement_unit, presence: true
end
