class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    if params[:query].present?
      @pins = Pin.search_full_text(params[:query]).order("created_at DESC")
    else
      @pins = Pin.all.order("created_at DESC")
    end
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.user_id = current_user.id

    if @pin.save
      redirect_to @pin, notice: "Pin posted"
    else
      render "new"
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
    params.require(:pin).permit(:title, :description, :photo)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
