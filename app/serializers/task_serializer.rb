# == Schema Information
#
# Table name: tasks
#
#  id               :bigint(8)        not null, primary key
#  kpi_points       :integer
#  notes            :text
#  task_finished_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :bigint(8)
#  user_id          :bigint(8)
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#  index_tasks_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :kpi_points, :notes, :task_finished_at

  has_one :user
  has_one :category
end
