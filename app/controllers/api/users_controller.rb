module Api
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def charge
    Stripe.api_key = 'sk_test_4TwzwS1VpbmI1RS5cduPmnW0'
    token = self.params[:stripeToken]
    params = self.params[:charge]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => params[:amount].to_i* 100, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => "payinguser@example.com"
      )
      @user = current_user
      @user.funds = @user.funds + params[:amount].to_i * 100
      @user.save!
      render json: @user
    rescue Stripe::CardError => e
      # The card has been declined
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :token, :username, :funds)
  end
  
end
end