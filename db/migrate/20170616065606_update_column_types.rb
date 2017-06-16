class UpdateColumnTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :stocks, :closing_date, :string
    change_column :bids, :closing_date, :string
  end
end
