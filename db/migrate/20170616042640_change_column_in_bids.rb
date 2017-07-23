class ChangeColumnInBids < ActiveRecord::Migration
  def change
    remove_column :bids, :quantity, :integer

    add_column :bids, :size, :integer
    add_column :bids, :gender, :string
    add_column :bids, :closing_date, :date

    rename_column :bids, :item_id, :stock_id
  end
end
