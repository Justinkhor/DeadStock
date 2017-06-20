class AddColumnToStocks < ActiveRecord::Migration[5.0]
  def change
    add_column :stocks, :sold, :boolean, default: false
  end
end
