class AddColumnToBids < ActiveRecord::Migration[5.0]
  def change
    add_column :bids, :chosen_bid, :boolean, default: false
    add_column :bids, :payment_made, :boolean, default: false
  end
end
