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

class Category < ApplicationRecord
  validates :kpi_period, inclusion: { in: [7, 30] }
  validates :kpi_quantity_goal, numericality: { greater_than: 0 }
  validates :name, presence: true, uniqueness: true
end
