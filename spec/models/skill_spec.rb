require "rails_helper"

RSpec.describe Skill, type: :model do
  subject { build(:skill) }

  describe "associations" do
    it { should have_many(:job_skills).dependent(:destroy) }
    it { should have_many(:jobs).through(:job_skills) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:slug) }
    it do
      should validate_inclusion_of(:category).in_array(
        %w[language framework database tool cloud methodology soft_skill]
      )
    end
  end

  describe "#slug" do
    context "when slug is blank" do
      before do
        subject.name = "Ruby on Rails"
        subject.slug = nil
        subject.valid?
      end

      it "generates slug from name" do
        expect(subject.slug).to eq("ruby-on-rails")
      end
    end

    context "when slug exists" do
      before do
        subject.name = "Ruby on Rails"
        subject.slug = "custom-slug"
        subject.valid?
      end

      it "does not override existing slug" do
        expect(subject.slug).to eq("custom-slug")
      end
    end
  end

  describe "#aliases" do
    it "defaults to empty array" do
      created_skill = create(:skill)
      expect(created_skill.aliases).to eq([])
    end

    it "stores multiple aliases" do
      aliased_skill = create(:skill, :with_aliases)
      expect(aliased_skill.aliases).to contain_exactly("Rails", "RoR")
    end
  end

  describe "#category" do
    context "with valid category" do
      before { subject.category = "language" }
      it { is_expected.to be_valid }
    end

    context "with invalid category" do
      before { subject.category = "invalid" }
      it { is_expected.not_to be_valid }
    end
  end
end
