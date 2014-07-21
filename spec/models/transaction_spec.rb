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

require 'rails_helper'

RSpec.describe Transaction, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
