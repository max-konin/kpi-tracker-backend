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

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :kpi_period, :kpi_quantity_goal
end
