# frozen_string_literal: true

module API
  module V1
    class StickersController < ApplicationController
      before_action :load_collection, :load_stickers, only: %i[index]
      before_action :load_sticker, only: %i[update]

      def index
        render json: @stickers, status: :ok
      end

      def update
        if @sticker.update(sticker_params)
          render json: @sticker
        else
          render json: @sticker.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def load_stickers
        @stickers = Sticker.by_collection(@collection)
        head :not_found if @stickers.empty?
      end

      def load_sticker
        @sticker = Sticker.by_uuid(params[:id])&.first
        head :not_found if @sticker.blank?
      end

      def load_collection
        @collection = Collection.by_uuid(params[:collection_id])&.first
        head :not_found if @collection.blank?
      end

      # Only allow a trusted parameter "white list" through.
      def sticker_params
        params.require(:sticker).permit(:quantity)
      end
    end
  end
end
