# == Schema Information
#
# Table name: categories
#
#  id                :bigint(8)        not null, primary key
#  kpi_period        :integer
#  kpi_quantity_goal :integer
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    subject { category.valid? }

    context 'when a name is not present' do
      let(:category) { build_stubbed :category, name: nil }
      it { is_expected.to be_falsey }
    end

    context 'when a name is not uniq' do
      let!(:other_category) { create :category, name: 'Name' }
      let(:category) { build_stubbed :category, name: 'Name' }
      it { is_expected.to be_falsey }
    end

    context 'when a kpi_period is not 7 or 30' do
      let(:category) { build_stubbed :category, kpi_period: 10 }
      it { is_expected.to be_falsey }
    end

    context 'when a kpi_quantity_goal is not integer' do
      let(:category) { build_stubbed :category, kpi_quantity_goal: 'fakse' }
      it { is_expected.to be_falsey }
    end

    context 'when a kpi_quantity_goal <= 0' do
      let(:category) { build_stubbed :category, kpi_quantity_goal: 0 }
      it { is_expected.to be_falsey }
    end

    context 'with valid attts' do
      let(:category) { build_stubbed :category }
      it { is_expected.to be_truthy }
    end
  end
end
