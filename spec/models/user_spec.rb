require 'rails_helper'

RSpec.describe User, type: :model do
  it "should be created a password and password_confirmation fields" do
    @user = User.new(
      name: "New User", 
      email: "test@test.com", 
      password: "password123", 
      password_confirmation: "password123")

    @user.save
    expect(@user).to be_valid
  end
end
