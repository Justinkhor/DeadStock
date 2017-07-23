class RemoveColumnFromBids < ActiveRecord::Migration
  def change
    remove_column :bids, :closing_date
  end
end
