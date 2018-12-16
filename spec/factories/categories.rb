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

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "cat##{n}" }
    kpi_period { 7 }
    kpi_quantity_goal { 1 }
  end
end
