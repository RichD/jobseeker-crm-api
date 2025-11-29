require "rails_helper"

RSpec.describe JobSkill, type: :model do
  subject { build(:job_skill) }

  describe "associations" do
    it { should belong_to(:job) }
    it { should belong_to(:skill) }
  end

  describe "validations" do
    it do
      should validate_inclusion_of(:classification).in_array(
        %w[required preferred mentioned]
      )
    end
  end

  describe "uniqueness" do
    let(:job) { create(:job) }
    let(:skill) { create(:skill) }

    it "prevents duplicate job-skill pairs" do
      create(:job_skill, job: job, skill: skill)

      duplicate = build(:job_skill, job: job, skill: skill)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:skill_id]).to include("has already been taken")
    end

    it "allows same skill for different jobs" do
      job2 = create(:job)
      create(:job_skill, job: job, skill: skill)

      different_job = build(:job_skill, job: job2, skill: skill)
      expect(different_job).to be_valid
    end
  end

  describe "#years_required" do
    context "when nil" do
      before { subject.years_required = nil }
      it { is_expected.to be_valid }
    end

    context "when a number" do
      before { subject.years_required = 5 }
      it { is_expected.to be_valid }

      it "stores the value" do
        expect(subject.years_required).to eq(5)
      end
    end
  end

  describe "#classification" do
    it "defaults to required" do
      created = create(:job_skill)
      expect(created.classification).to eq("required")
    end
  end
end
