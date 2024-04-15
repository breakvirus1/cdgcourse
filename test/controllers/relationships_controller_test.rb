require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(email: "test@example.com", password: "password123", password_confirmation: "password123")
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user = User.new(password: "password123", password_confirmation: "password123")
      expect(user).not_to be_valid
    end

    it "is not valid without a password" do
      user = User.new(email: "test@example.com")
      expect(user).not_to be_valid
    end

    it "is not valid with a duplicate email address" do
      User.create(email: "test@example.com", password: "password123", password_confirmation: "password123")
      user = User.new(email: "test@example.com", password: "password456", password_confirmation: "password456")
      expect(user).not_to be_valid
    end

    it "is not valid with a password less than 6 characters" do
      user = User.new(email: "test@example.com", password: "pass", password_confirmation: "pass")
      expect(user).not_to be_valid
    end
  end

  describe "authentication" do
    let(:user) { create(:user, email: "test@example.com", password: "password123") }

    it "authenticates with correct credentials" do
      authenticated_user = User.authenticate(user.email, user.password)
      expect(authenticated_user).to eq(user)
    end

    it "does not authenticate with incorrect password" do
      authenticated_user = User.authenticate(user.email, "wrong_password")
      expect(authenticated_user).to be_nil
    end

    it "does not authenticate with incorrect email" do
      authenticated_user = User.authenticate("wrong_email@example.com", user.password)
      expect(authenticated_user).to be_nil
    end
  end
end