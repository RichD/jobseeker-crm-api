require "rails_helper"

RSpec.describe "Api::V1::JobSkills", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers_for(user) }
  let!(:job) { create(:job, user: user) }

  describe "GET /index" do
    subject(:list_skills) { get api_v1_job_skills_path(job_id: job.id), headers: headers, params: params }

    let(:params) { {} }

    context "when user is not authenticated" do
      let(:headers) { {} }

      before { list_skills }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when accessing another user's job" do
      let(:other_job) { create(:job, user: create(:user)) }

      before { get api_v1_job_skills_path(job_id: other_job.id), headers: headers }

      it "returns 404" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "with no job skills defined" do
      before { list_skills }

      it "returns empty array" do
        expect(response).to have_http_status(:ok)
        expect(json_response[:skills]).to eq([])
      end
    end

    context "with job skills defined" do
      before do
        create(:job_skill, job: job)
        list_skills
      end

      it "returns array of skills with metadata" do
        expect(response).to have_http_status(:ok)
        expect(json_response[:skills].length).to eq(1)

        expect(json_response[:skills].first).to include(
          :id, :skill, :years_required, :classification
        )

        expect(json_response[:skills].first[:skill]).to include(
          :id, :name, :slug, :category, :aliases
        )
      end
    end

    context "with suggest param set" do
      let(:params) { { suggest: true } }
      let(:ruby_skill) { create(:skill, name: "Ruby") }

      before do
        ruby_skill
        job.update(description: "Looking for Ruby developer")
        list_skills
      end

      it "returns suggested skills from extractor" do
        expect(response).to have_http_status(:ok)
        expect(json_response[:suggested_skills].map { |s| s[:id] }).to include(ruby_skill.id)
        expect(json_response[:suggested_skills].first).to include(
          :id, :name, :slug, :category, :aliases
        )
      end
    end
  end

  describe "POST /create" do
    subject(:create_skills) { post api_v1_job_skills_path(job_id: job.id), headers: headers, params: params }

    context "when user is not authenticated" do
      let(:params) { { skills: [] } }
      let(:headers) { {} }

      before { create_skills }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with valid skills" do
      let(:ruby_skill) { create(:skill, name: "Ruby") }
      let(:rails_skill) { create(:skill, name: "Rails") }
      let(:params) do
        {
          skills: [
            { skill_id: ruby_skill.id, years_required: 5, classification: "required" },
            { skill_id: rails_skill.id, years_required: nil, classification: "preferred" }
          ]
        }
      end

      it "creates job_skills" do
        expect { create_skills }.to change(JobSkill, :count).by(2)
        expect(response).to have_http_status(:created)
      end

      it "returns created job_skills with nested skill data" do
        create_skills
        expect(json_response[:job_skills].length).to eq(2)
        expect(json_response[:job_skills].first[:skill][:name]).to eq("Ruby")
        expect(json_response[:job_skills].first[:skill]).to include(
          :id, :name, :slug, :category, :aliases
        )
      end
    end

    context "with invalid skill_id" do
      let(:params) { { skills: [{ skill_id: 99999, years_required: 5, classification: "required" }] } }

      before { create_skills }

      it "returns 422" do
        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context "with duplicate skills" do
      let(:ruby_skill) { create(:skill, name: "Ruby") }
      let(:params) { { skills: [{ skill_id: ruby_skill.id, years_required: 3, classification: "required" }] } }

      before do
        create(:job_skill, job: job, skill: ruby_skill)
        create_skills
      end

      it "returns validation error" do
        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:errors]).to be_present
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:delete_skill) do
      delete api_v1_job_skill_path(job_id: job.id, id: job_skill_id), headers: headers
    end

    let(:job_skill) { create(:job_skill, job: job) }
    let(:job_skill_id) { job_skill.id }

    context "when user is not authenticated" do
      let(:headers) { {} }

      before { delete_skill }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when skill exists" do
      it "deletes the job_skill" do
        job_skill
        expect { delete_skill }.to change(JobSkill, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when skill does not exist" do
      let(:job_skill_id) { 99999 }

      before { delete_skill }

      it "returns 404" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
