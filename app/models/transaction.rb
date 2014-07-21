# == Schema Information
#
# Table name: transactions
#
#  id         :integer          not null, primary key
#  symbol     :string(255)
#  action     :string(255)
#  quantity   :integer
#  user_id    :integer
#  rate       :float
#  amount     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Transaction < ActiveRecord::Base
  attr_accessible :action, :amount, :quantity, :rate, :symbol
  belongs_to :user
end
