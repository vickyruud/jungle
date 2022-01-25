require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'Is user valid' do
      @user = User.new(
        first_name: 'James',
        last_name: 'May',
        email: 'captainslow@grandtour.com',
        password: 'password',
        password_confirmation: 'password' 
      )
      @user.valid?
      expect(@user).to be_valid
    end
    it 'should have a password and password_confirmation' do
      @user = User.new(
        first_name: 'James',
        last_name: 'May',
        email: 'captainslow@grandtour.com',
        password: nil,
        password_confirmation: nil
      ) # should not be valid
      @user.valid?
      expect(@user).not_to be_valid

      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'password and password_confirmation should match' do
      @user = User.new(
        first_name: 'James',
        last_name: 'May',
        email: 'captainslow@grandtour.com',
        password: 'password',
        password_confirmation: 'pass'
      )# should be an error
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")

      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user.errors[:password_confirmation]).not_to include("doesn't match Password")
    end

    it 'Email should be present' do
      @user = User.new(email: nil) #should create an error
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
      
      @user.email = "captslow@gt.com"
      @user.valid?
      expect(@user.errors[:email]).not_to include("can't be blank")
    end

     it 'first_name should be present' do
      @user = User.new(first_name: nil) #should create an error
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank")
      
      @user.first_name = "James"
      @user.valid?
      expect(@user.errors[:first_name]).not_to include("can't be blank")
    end

     it 'last_name should be present' do
      @user = User.new(last_name: nil) #should create an error
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
      
      @user.last_name = "May"
      @user.valid?
      expect(@user.errors[:last_name]).not_to include("can't be blank")
    end

    it 'Password should have a minimum length of 8 characters' do
      @user = User.new(
        password: 'pass',
        password_confirmation: 'pass'
      )
      @user.valid?
      expect(@user.errors[:password]).to include ("is too short (minimum is 8 characters)")

      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user.errors[:password]).not_to include ("is too short (minimum is 8 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should log the user in if email is correct' do
      @user = User.new(first_name: "James",
      last_name: "May",
      email: "jamesmay@gmail.com",
      password: "password",
      password_confirmation: "password")

      @user.save!
      expect(User.authenticate_with_credentials("jamesmay@gmail.com", "password")).to be_present
      
    end
    it 'should not login if email is incorrect' do
      @user = User.new(first_name: "James",
      last_name: "May",
      email: "jamesmay@gmail.com",
      password: "password",
      password_confirmation: "password")
      @user.save!
      #Incorrect email should not allow it to login
      expect(User.authenticate_with_credentials("jamesmay1@gmail.com", "password")).not_to be_present
    end
    it 'should login if email has spaces' do
      @user = User.new(first_name: "James",
      last_name: "May",
      email: "jamesmay@gmail.com",
      password: "password",
      password_confirmation: "password")
      @user.save!
      expect(User.authenticate_with_credentials(" jamesmay@gmail.com ", "password")).to be_present

    end
    it 'should login if email has different cases' do
      @user = User.new(first_name: "James",
      last_name: "May",
      email: "jamesmay@gmail.com",
      password: "password",
      password_confirmation: "password")
      @user.save!
      expect(User.authenticate_with_credentials(" jaMeSmAY@gmail.com ", "password")).to be_present

    end
  end
end

