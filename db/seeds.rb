
xlsx = Roo::Spreadsheet.open(File.join(Rails.root,  "sneakers_price_simulation3.xlsx")) 

xlsx.sheet(0).each do |row|
  HistoricalTable.create(model_number: row[0] ,date_time: row[1] , transacted_price: row[2], item_id: row[3],fx_pair: row[4], fx_rate: row[5], transacted_price_myr: row[6] )
end

xlsx_2 = Roo::Spreadsheet.open(File.join(Rails.root,  "sneakers_index.xlsx")) 

xlsx_2.sheet(0).each do |row|
  IndexTable.create(index_date: row[0] ,jordan_index: row[1] , nike_index: row[2], adidas_index: row[3])
 end