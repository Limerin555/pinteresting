class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Sign up successful"
    else
      render 'new', notice: "Failed to sign up, try again."
    end
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user.save
      redirect_to @user, notice: "User Profile successfully updated"
    else
      render "edit", notice: "Update not successful, try again."
    end
  end

  def destroy
    @user = User.find(params[:id])
    session[:user_id] = nil
    @user.destroy
    redirect_to root_path, notice: "User Profile deleted, please sign up again to be a User."
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :profpic)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
