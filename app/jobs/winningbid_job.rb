class WinningbidJob < ActiveJob::Base
  queue_as :default

  def perform(bidder_id, bid_id)
     BidMailer.winning_bid_and_payment_email(bidder_id, bid_id).deliver_now
  end
end
