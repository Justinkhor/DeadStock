class BidMailer < ApplicationMailer
  def expired_bid_email(bidder_id, item_id)
    @item = Item.find(item_id)
    @bidder = User.find(bidder_id)
    @url = "http://localhost:3000/items/#{item_id}"

    mail(to: @bidder.email, subject: "Outbidden")
  end

  def winning_bid_and_payment_email(bidder_id, bid_id)
    @bidder = User.find(bidder_id)
    @url = "http://localhost:3000/bids/#{bid_id}/braintree/new"

    mail(to: @bidder.email, subject: "Highest Bidder and Payment")
  end

  def bought_item_email()
  end

  def sold_item_email()
  end
end
