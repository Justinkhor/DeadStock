class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :item, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
