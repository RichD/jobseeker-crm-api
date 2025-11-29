require "rails_helper"

RSpec.describe SkillExtractorService, type: :service do
  describe ".extract" do
    subject(:extracted_skills) { described_class.extract(text) }

    let!(:ruby) { create(:skill, name: "Ruby", aliases: []) }
    let!(:rails) { create(:skill, name: "Ruby on Rails", aliases: %w[Rails RoR]) }
    let!(:react) { create(:skill, name: "React", aliases: ["ReactJS", "React.js"]) }

    context "when text is blank" do
      let(:text) { "" }

      it { is_expected.to be_empty }
    end

    context "when text has exact skill name match" do
      let(:text) { "Looking for React experience" }

      it { is_expected.to contain_exactly(react) }
    end

    context "when text has alias match" do
      let(:text) { "5 years of Rails experience" }

      it { is_expected.to contain_exactly(rails) }
    end

    context "when text has substring skill names" do
      let(:text) { "Ruby on Rails developer" }

      it "returns the longer skill" do
        expect(extracted_skills).to contain_exactly(rails)
      end

      it "does not return the substring skill" do
        expect(extracted_skills).not_to include(ruby)
      end
    end

    context "when text has multiple skills" do
      let(:text) { "React and Rails experience" }

      it { is_expected.to contain_exactly(rails, react) }
    end

    context "when text has case variations" do
      let(:text) { "REACT and rails experience" }

      it { is_expected.to contain_exactly(rails, react) }
    end

    context "when text has partial word matches" do
      let(:text) { "reacting to rubycolored text" }

      it { is_expected.to be_empty }
    end

    context "when text has duplicate mentions" do
      let(:text) { "React, React, React everywhere" }

      it { is_expected.to contain_exactly(react) }
    end
  end
end
