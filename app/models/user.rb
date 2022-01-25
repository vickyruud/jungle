class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: {minimum: 8}
  validates :password_confirmation, presence: true
  validates :email, presence: true

  def self.authenticate_with_credentials(email, password)
    @user = self.find_by_email(email.delete(' ').downcase).try(:authenticate, password)
  end
end
