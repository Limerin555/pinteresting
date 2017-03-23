class DonationsController < ApplicationController
  def new
  @client_token = Braintree::ClientToken.generate
end

def checkout
  @pin = Pin.find(params[:pin_id])
  standard_amount = 10

  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

  result = Braintree::Transaction.sale(
   :amount => standard_amount,
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

  if result.success?
    @pin.money = @pin.money + standard_amount
    @pin.save
    donation = @pin.donations.new(amount: standard_amount, user_id: current_user.id)
    donation.save


    redirect_to @pin, :flash => { :success => "Transaction successful! Thank you for your support." }
  else
    redirect_to @pin, :flash => { :error => "Transaction failed. Please try again." }
  end
end
end
