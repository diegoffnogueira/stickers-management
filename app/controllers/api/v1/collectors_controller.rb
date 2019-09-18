# frozen_string_literal: true

module API
  module V1
    class CollectorsController < ApplicationController
      before_action :load_collector, only: %i[show destroy]

      # GET /collectors/1
      def show
        render json: @collector, status: :ok
      end

      # POST /collectors
      def create
        @collector = Collector.new(collector_params)

        if @collector.save
          render json: @collector, status: :created
        else
          render json: @collector.errors, status: :unprocessable_entity
        end
      end

      # DELETE /collectors/1
      def destroy
        @collector.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def load_collector
        @collector = Collector.by_uuid(params[:id])&.first
        head :not_found if @collector.blank?
      end

      # Only allow a trusted parameter "white list" through.
      def collector_params
        params.require(:collector).permit(:name, :email)
      end
    end
  end
end
