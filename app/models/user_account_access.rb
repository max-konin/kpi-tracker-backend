# == Schema Information
#
# Table name: user_account_accesses
#
#  id          :bigint(8)        not null, primary key
#  access_type :integer          default("owner"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint(8)
#  user_id     :bigint(8)
#
# Indexes
#
#  index_user_account_accesses_on_account_id  (account_id)
#  index_user_account_accesses_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#

class UserAccountAccess < ApplicationRecord
  belongs_to :user
  belongs_to :account
  enum access_type: { owner: 0, admin: 1, limited: 2 }
end
