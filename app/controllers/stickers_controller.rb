class StickersController < ApplicationController
  before_action :set_sticker, only: [:show, :update, :destroy]

  # GET /stickers
  def index
    @stickers = Sticker.all

    render json: @stickers
  end

  # GET /stickers/1
  def show
    render json: @sticker
  end

  # POST /stickers
  def create
    @sticker = Sticker.new(sticker_params)

    if @sticker.save
      render json: @sticker, status: :created, location: @sticker
    else
      render json: @sticker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stickers/1
  def update
    if @sticker.update(sticker_params)
      render json: @sticker
    else
      render json: @sticker.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stickers/1
  def destroy
    @sticker.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sticker
      @sticker = Sticker.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sticker_params
      params.require(:sticker).permit(:uuid, :collection_id, :number, :quantity)
    end
end
