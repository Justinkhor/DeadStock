class AddColumnsToHistoricalTable < ActiveRecord::Migration
  def change
    add_column :historical_tables, :fx_pair, :string
    add_column :historical_tables, :fx_rate, :decimal
    add_column :historical_tables, :transacted_price_myr, :decimal
  end
end
