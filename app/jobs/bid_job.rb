class BidJob < ActiveJob::Base
  queue_as :default

  def perform(bidder_id, item_id)
     BidMailer.expired_bid_email(bidder_id, item_id).deliver_now
  end
end
