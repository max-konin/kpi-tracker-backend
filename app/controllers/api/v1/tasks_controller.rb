module Api
  module V1
    class TasksController < Api::V1::ApiController
      include Pundit

      before_action :doorkeeper_authorize!
      before_action :set_task, only: %i[show update destroy]

      INCLUDED_DATA = %i[category user].freeze

      def create
        save_and_render Task.new(task_params), :created
      end

      def destroy
        authorize @task
        @task.destroy
        head :ok
      end

      def update
        authorize @task
        @task.assign_attributes task_params
        save_and_render @task
      end

      def index
        render json: Task.all.ransack(params[:q]).result.includes(*INCLUDED_DATA),
               include: INCLUDED_DATA
      end

      def show
        render json: @task, include: INCLUDED_DATA
      end

      private

      def set_task
        @task = Task.find params[:id]
      end

      def save_and_render(task, success_status = :ok)
        if task.save
          render json: task, include: INCLUDED_DATA, status: success_status
        else
          render json: task, status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def task_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params).slice(
          :category_id, :kpi_points, :notes, :task_finished_at
        ).merge(user_id: current_user.id)
      end
    end
  end
end
