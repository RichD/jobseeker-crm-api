require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "associations" do
    it { should have_many(:jobs) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("invalid_email").for(:email) }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe "secure password" do
    it { should have_secure_password }
  end

  describe "email normalization" do
    let(:user) { create(:user, email: "UPPERCASE@EXAMPLE.COM") }

    it "converts email to lowercase before saving" do
      expect(user.email).to eq("uppercase@example.com")
    end
  end
end
