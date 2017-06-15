# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

xlsx = Roo::Spreadsheet.open(File.join(Rails.root,  "sneakers_price_simulation1.xlsx")) 

xlsx.sheet(0).each do |row|
  HistoricalTable.create(model_number: row[0] ,date_time: row[1] , transacted_price: row[2])
end
     