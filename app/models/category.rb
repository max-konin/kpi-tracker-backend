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
class Category < ApplicationRecord
  validates :kpi_period, inclusion: { in: [7, 30] }
  validates :kpi_quantity_goal, numericality: { greater_than: 0 }
  validates :name, presence: true
end
