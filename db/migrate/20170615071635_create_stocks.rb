class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.references :user
      t.references :item
      t.integer :size
      t.string :gender
      t.integer :resell_price
      t.date :closing_date
      t.timestamps
    end

    remove_column :users, :age
    remove_column :users, :gender
    remove_column :items, :gender
    remove_column :items, :size
    remove_column :items, :quantity
    remove_column :items, :resell_price

  end
end
