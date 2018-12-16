module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        render json: Category.all
      end

      def show
        render json: Category.find(params[:id])
      end
    end
  end
end
