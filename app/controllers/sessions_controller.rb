class SessionsController < ApplicationController

  def new
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

  # def create_from_omniauth
  #   auth = request.env["omniauth.auth"]
  #   session[:omniauth] = auth.except('extra')
  #   @fb_user = User.sign_in_from_omniauth(auth)
  #   session[:user_id] = @fb_user.id
  #   redirect_to user_path(@fb_user), notice: "Signed in"
  #   else
  #     notice: "Sign in unsuccessful, try again."
  #   end
  # end

  # add_column :users, :provider, :string
  #
  # add_column :users, :uid, :string
  #
  # add_column :users, :name, :string


  def destroy
    session[:user_id] = nil
    # session[:omniauth] = nil
    redirect_to root_path, notice: "Successfully signed out"
  end
end
