require "rails_helper"

RSpec.describe Job, type: :model do
  subject { build(:job) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:job_skills) }
    it { should have_many(:skills) }
  end

  describe "enums" do
    let(:values) { %i[saved applied interviewing offer rejected] }

    it { should define_enum_for(:status).with_values(values) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:status) }

    it { should allow_value("https://...").for(:url) }
    it { should allow_value("http://...").for(:url) }
    it { should allow_value(nil).for(:url) }
    it { should allow_value(" ").for(:url) }
    it { should_not allow_value("invalid").for(:url) }
    it { should_not allow_value("ftp://...").for(:url) }
  end
end
