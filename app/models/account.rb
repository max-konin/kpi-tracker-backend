# == Schema Information
#
# Table name: accounts
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ApplicationRecord
  has_many :user_account_accesses
  has_many :users, through: :user_account_accesses
end
