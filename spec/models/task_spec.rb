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

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#valid?' do
    subject { task.valid? }

    context 'when a notes is not present' do
      let(:task) { build_stubbed :task, notes: nil }
      it { is_expected.to be_falsey }
    end

    context 'when a notes is not present' do
      let(:task) { build_stubbed :task, task_finished_at: nil }
      it { is_expected.to be_falsey }
    end

    context 'when a kpi_points <= 0' do
      let(:task) { build_stubbed :task, kpi_points: 0 }
      it { is_expected.to be_falsey }
    end

    context 'with valid attts' do
      let(:task) { build_stubbed :task }
      it { is_expected.to be_truthy }
    end
  end
end
