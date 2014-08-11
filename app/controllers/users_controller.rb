class UsersController < ApplicationController
  
  
  before_filter :require_signed_out!, :only => :new
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: @user
    end
  end

  def show
    @user = User.find(params[:id])
    # get rid of password digest
    render json: @user
  end

  def currentuser
    @user = current_user
    render json: @user
  end

  private
  def user_params
    params.require(:user).permit(:password, :token, :username, :funds, :email)
  end
  
end
