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

FactoryBot.define do
  factory :category do
    name { 'Influencer outreach' }
    kpi_period { 7 }
    kpi_quantity_goal { 1 }
  end
end
