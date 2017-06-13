class BidMailer < ApplicationMailer
  default from: 'justinairbnbclone@gmail.com'
  def bid_email(customer, host, item_id, bid_id)
      @host = host
      @customer = customer
      @item = Item.find(item_id)
      @bid_id = bid_id
      #once customer reserved a item, it will send email to the item host.
      mail(to: @host.email, subject: "You have received a booking from #{@customer}")
  end
end
