module API
  module V1
    class AlbumsController < ApplicationController
      before_action :load_albuns, only: %i[index]
      before_action :load_album, only: %i[show update]

      # GET /albums
      def index
        render json: @albums, status: :ok
      end

      # GET /albums/1
      def show
        render json: @album, status: :ok
      end

      # POST /albums
      def create
        @album = Album.new(album_params)

        if @album.save
          render json: @album, status: :created
        else
          render json: @album.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /albums/1
      def update
        if @album.update(album_params)
          render json: @album, status: :ok
        else
          render json: @album.errors, status: :unprocessable_entity
        end
      end

      private

      def load_albuns
        @albums = Album.all
        head :not_found if @albums.empty?
      end

      def load_album
        @album = Album.by_uuid(params[:id])&.first
        head :not_found if @album.blank?
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_album
        @album = Album.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def album_params
        params.require(:album).permit(:name, :description, :number_of_stickers)
      end
    end
  end
end

