class UpdateColumns < ActiveRecord::Migration
  def change
    change_column :bids, :chosen_bid, :boolean, default: true
    add_column :bids, :bought, :boolean, default: false
  end
end
