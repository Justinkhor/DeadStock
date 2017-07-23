class CreateIndexTables < ActiveRecord::Migration
  def change
    create_table :index_tables do |t|
       t.date :index_date
       t.integer :jordan_index
       t.integer :nike_index
       t.integer :adidas_index

       t.timestamps
    end
  end
end
