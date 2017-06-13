class BidJob < ActiveJob::Base
  queue_as :default

  def perform(cust_email, host_email, item_id, bid_id)
     BidMailer.bid_email(cust_email, host_email, item_id, bid_id).deliver_now
  end
end
