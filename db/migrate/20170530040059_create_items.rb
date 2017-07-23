class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :gender
      t.string :color
      t.string :model_number
      t.string :category
      t.string :brand
      t.integer :size
      t.integer :retail_price
      t.integer :resell_price
      t.integer :quantity
      t.date :release_date
      t.timestamps
    end
  end
end
