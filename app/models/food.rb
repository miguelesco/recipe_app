class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, uniqueness: { scope: :user_id, message: 'You have already added this ingreddient' }, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :measurement_unit,
            inclusion: { in: ['Teaspoon (tsp)', 'Cup (c)', 'Unit (u)', 'Milliliter (ml)', 'Litter (l)',
                              'Milligram (mg)', 'Kilogram (kg)'] }
end
