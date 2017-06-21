class UpdateColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :bids, :chosen_bid, :boolean, default: true
    add_column :bids, :bought, :boolean, default: false
  end
end
