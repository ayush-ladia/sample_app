# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#  cash_in_hand    :float
#  total_portfolio :float
#  password        :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :cash_in_hand, :password, :password_confirmation
 
  has_secure_password
  has_many :stocks
  has_many :transactions

  before_create :validate_user
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  private

    def create_remember_token
      if self.password.present?
        self.remember_token = SecureRandom.urlsafe_base64
      end
    end

    def validate_user
      self.cash_in_hand = 10000
      self.password == self.password_confirmation
    end
end

