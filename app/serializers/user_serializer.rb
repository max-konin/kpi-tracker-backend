# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :account

  def account
    account_user = @instance_options[:account_user]
    account_user&.account
  end
end
