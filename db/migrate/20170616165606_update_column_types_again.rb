class UpdateColumnTypesAgain < ActiveRecord::Migration
    def change
      remove_column :stocks, :closing_date
      remove_column :bids, :closing_date

      add_column :stocks, :closing_date, :date
      add_column :bids, :closing_date, :date
    end
  end
