class CreateRecipesFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes_foods do |t|
      t.float :quantity
      t.references :food, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
