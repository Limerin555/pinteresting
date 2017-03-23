class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    @user = User.from_omniauth(env["omniauth.auth"])
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Signed in"
    else
      render "new", notice: "Invalid email or password"
    end
  end

  # def create_from_omniauth
  #
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully signed out"
  end
end
