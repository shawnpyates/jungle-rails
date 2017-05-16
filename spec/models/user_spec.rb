require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before :each do
      @user = User.new(name: "Bob Garcia",
                       email: "bobbyg@geemail.com",
                       password: "hello123",
                       password_confirmation: "hello123")
    end
    it "should succeed if user has all values prodived" do
      expect(@user.valid?).to be true
    end
    it "should validate that password and password confirmation match" do
      @user.password_confirmation = "goodbye123"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should validate presence of password and password confirmation" do
      @user.password = nil
      @user.password_confirmation = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "should validate existence of email" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "should validate uniqueness of email" do
      @user.save!
      new_user = User.new(name: "Bob Gray",
                          email: "bobbyg@geemail.com",
                          password: "lalala",
                          password_confirmation: "lalala")
      new_user.valid?
      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end 
    it "should validate presence of name" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it "should validate presence of both first and last name" do
      @user.name = "Bobby"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name must contain both a first name and last name")
    end 
    it "should validate length of password" do
      @user.password = "no"
      @user.password_confirmation = "no"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end               
  end

  describe '.authenticate_with_credentials' do
    before :each do
    @user = User.create(name: "Bob Garcia",
                     email: "bobbyg@geemail.com",
                     password: "hello123",
                     password_confirmation: "hello123")
    end
    it "should authenticate when credentials are correct" do
      login_user = User.authenticate_with_credentials("bobbyg@geemail.com", "hello123")
      expect(login_user).not_to be_nil
    end
    it "should reject when credentials are incorrect" do
      login_user = User.authenticate_with_credentials("bobbyg@geemail.com", "helloooo")
      expect(login_user).to be_nil
    end
    it "should authenticate even if email is typed in different case" do
      login_user = User.authenticate_with_credentials("BOBBYg@geeMAIL.com", "hello123")
      expect(login_user).not_to be_nil
    end
    it "should reject if password is typed in different case" do
      login_user = User.authenticate_with_credentials("bobbyg@geemail.com", "HELLO123")
      expect(login_user).to be_nil
    end
    it "should authenticate even if email contains whitespace at beginning or end" do
      login_user = User.authenticate_with_credentials("bobbyg@geemail.com    ", "hello123")
      expect(login_user).not_to be_nil
    end
  end
end
