module Api
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  private
  def user_params
    params.require(:user).permit(:password, :token, :username)
  end
  
end
end