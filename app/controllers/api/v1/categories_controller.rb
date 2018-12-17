module Api
  module V1
    class CategoriesController < Api::V1::ApiController
      def index
        render json: Category.all
      end

      def show
        render json: Category.find(params[:id])
      end
    end
  end
end
