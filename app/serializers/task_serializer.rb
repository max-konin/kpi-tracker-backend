class TaskSerializer < ActiveModel::Serializer
  attributes :id, :kpi_points, :notes, :task_finished_at

  has_one :user
  has_one :category
end
