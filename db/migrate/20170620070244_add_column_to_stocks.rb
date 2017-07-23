class AddColumnToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :sold, :boolean, default: false
  end
end
