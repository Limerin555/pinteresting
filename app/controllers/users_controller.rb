class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, :notice => "Sign up successful"
    else
      render '/sign_up', :notice => "Failed to sign up, try again."
    end
  end

  def edit
  end

  def update
    # if @user.update(user_params)
    #   redirect_to @user, notice: "User Profile successfully updated"
    # else
    #   render "edit"
    # end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
