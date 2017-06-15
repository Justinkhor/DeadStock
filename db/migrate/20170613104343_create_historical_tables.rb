class CreateHistoricalTables < ActiveRecord::Migration[5.0]
  def change
    create_table :historical_tables do |t|
       t.string :model_number
       t.datetime :date_time
       t.integer :transacted_price
       t.references :item

       t.timestamps
    end
  end
end
