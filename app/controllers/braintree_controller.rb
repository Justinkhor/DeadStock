class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @bid = Bid.find(params[:bid_id])
  end

  def create
    @bid = Bid.find(params[:bid_id])
    @stock = @bid.stock
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    amount_to_be_paid = @bid.bidding_price

    result = Braintree::Transaction.sale(
     :amount => amount_to_be_paid,
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )
      if result.success?
        @bid.payment_made = true
        @bid.save
        redirect_to user_path(current_user), notice: "Transaction successful!"
      else
        redirect_to user_path(current_user), notice: "Transaction failed. Please try again."
      end
    end
end
