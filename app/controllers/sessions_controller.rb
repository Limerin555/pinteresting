class SessionsController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Signed in"
    else
      render "new", notice: "Invalid email or password"
    end
  end

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      @user = authentication.user
      authentication.update_token(auth_hash)
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Signed in"
    else
      @user = User.create_with_auth_and_hash(authentication, auth_hash)
      # session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "User Profile created"
    # else
      # redirect_to root_path, notice: "Something went wrong, please try again."
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully signed out"
  end
end
