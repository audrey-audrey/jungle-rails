require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation: User' do
    it "is valid with matching password and password_confirmation fields" do
      @user = User.new(
        name: "New User", 
        email: "test@test.com", 
        password: "password123", 
        password_confirmation: "password123")
  
      @user.save
      expect(@user).to be_valid
    end

    it "is not valid without matching password and password_confirmation fields" do
      @user = User.new(
        name: "New User", 
        email: "test@test.com", 
        password: "password", 
        password_confirmation: "password123")
  
      @user.save
      expect(@user).to_not be_valid
    end

    it "is case sensitive and must contain unique email" do
      @user1 = User.new(
        name: "New User", 
        email: "TEST@TEST.com", 
        password: "password123", 
        password_confirmation: "password123")
      @user1.save

      @user2 = User.new(
        name: "Another User", 
        email: "test@test.COM",
        password: "password456", 
        password_confirmation: "password456")
      @user2.save

      expect(@user2).to_not be_valid
    end
  end
end
