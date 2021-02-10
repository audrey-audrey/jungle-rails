class User < ActiveRecord::Base

  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }, presence:true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 8 }

  before_create :format_email

  def self.authenticate_with_credentials (email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end 
  end

  def format_email
    self.email.downcase.strip
  end
  
end
