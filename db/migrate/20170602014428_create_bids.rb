class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user
      t.references :item
      t.integer :bidding_price
      t.integer :quantity
      t.timestamps
    end
  end
end
