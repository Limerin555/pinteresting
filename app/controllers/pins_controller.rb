class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :set_auth

  def index
    if params[:query].present?
      @pin = Pin.new
      @pins = Pin.search_full_text(params[:query]).order("created_at DESC")
    else
      @pin = Pin.new
      @pins = Pin.all.order("created_at DESC")
    end
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.user_id = current_user.id

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin posted.' }
        format.json { render :show, status: :created, location: @pin }
        format.js
      else
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end



  def show
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Pin successfully updated"
    else
      render "edit"
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end

  # def upvote
  #   @pin.upvote_by current_user
  #   redirect_to :back
  # end

  private
  def pin_params
    params.require(:pin).permit(:title, :description, :photo, :donation)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end
end
