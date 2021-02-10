require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation: User' do
    it "is valid with matching password and password_confirmation fields" do
      @user = User.new(
        first_name: "New",
        last_name: "User",
        email: "test@test.com", 
        password: "password123", 
        password_confirmation: "password123")
  
      @user.save
      expect(@user).to be_valid
    end

    it "is not valid without matching password and password_confirmation fields" do
      @user = User.new(
        first_name: "New",
        last_name: "User",
        email: "test@test.com", 
        password: "password", 
        password_confirmation: "password123")
  
      @user.save
      expect(@user).to_not be_valid
    end

    it "is case sensitive and must contain unique email" do
      @user1 = User.new(
        first_name: "New",
        last_name: "User",
        email: "TEST@TEST.com", 
        password: "password123", 
        password_confirmation: "password123")
      @user1.save

      @user2 = User.new(
        first_name: "Other",
        last_name: "User", 
        email: "test@test.COM",
        password: "password456", 
        password_confirmation: "password456")
      @user2.save

      expect(@user2).to_not be_valid
    end

    it "is not valid without first name" do
      @user = User.new(
        first_name: nil,
        last_name: "User",
        email: "test@test.com", 
        password: "password", 
        password_confirmation: "password123")
  
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end


    it "is not valid without last name" do
      @user = User.new(
        first_name: "New",
        last_name: nil,
        email: "test@test.com", 
        password: "password", 
        password_confirmation: "password123")
  
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end


    it "is not valid without email" do
      @user = User.new(
        first_name: "New",
        last_name: "User",
        email: nil, 
        password: "password", 
        password_confirmation: "password123")
  
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
  end

  describe 'Password' do
    it "is not valid if less than 8 characters" do
      @user = User.new(
        first_name: "New",
        last_name: "User",
        email: "test@test.com", 
        password: "1234567", 
        password_confirmation: "1234567")
  
      @user.save
      expect(@user).to_not be_valid
    end
  end
end
