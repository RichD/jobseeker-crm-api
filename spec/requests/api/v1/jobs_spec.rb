require "rails_helper"

RSpec.describe "Api::V1::Jobs", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers_for(user) }

  describe "GET /api/v1/jobs" do
    let(:another_user) { create(:user) }

    before do
      create(:job, user: user)
      create(:job, user: user)
      create(:job, user: another_user)
      get api_v1_jobs_path, headers: headers
    end

    it "returns 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns array of jobs" do
      expect(json_response["jobs"]).to be_an(Array)
    end

    it "returns only current user's jobs" do
      expect(json_response["jobs"].size).to eq(2)
    end
  end

  describe "POST /api/v1/jobs" do
    subject(:created_job) { Job.last }

    let(:params) do
      {
        job: {
          title: "Software Engineer",
          company: "Stealth Startup",
          status: "saved"
        }
      }
    end

    before do
      post api_v1_jobs_path, headers: headers, params: params
    end

    context "with valid params (title, company, status)" do
      it "returns 201" do
        expect(response).to have_http_status(:created)
      end

      it "creates job, returns job data" do
        expect(json_response.dig("job", "id")).to eq(created_job.id)
        expect(json_response.dig("job", "title")).to eq("Software Engineer")
        expect(json_response.dig("job", "company")).to eq("Stealth Startup")
      end
    end

    context "with invalid params (missing title)" do
      let(:params) { { job: { company: "Stealth Startup", status: "saved" } } }

      it "returns 422" do
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "returns errors" do
        expect(json_response.dig("errors", "title")).to be_present
      end
    end

    context "without authentication" do
      let(:headers) { {} }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /api/v1/jobs/:id" do
    let!(:job) { create(:job, user: user) }
    let(:another_user) { create(:user) }
    let(:new_title) { "Senior Software Engineer" }

    before do
      patch api_v1_job_path(job.id),
            headers: headers,
            params: { job: { title: new_title } }
    end

    context "when user updates own job" do
      it "returns 200" do
        expect(response).to have_http_status(:ok)
      end

      it "updates the job" do
        expect(job.reload.title).to eq(new_title)
      end

      it "returns updated job data" do
        expect(json_response.dig("job", "title")).to eq(new_title)
      end
    end

    context "when user tries to update another user's job" do
      let!(:job) { create(:job, user: another_user) }

      it "returns 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "does not update the job" do
        expect(job.reload.title).not_to eq(new_title)
      end
    end

    context "when user tries to make an invalid update" do
      let!(:job) { create(:job, user: user) }
      let(:new_title) { "" }

      it "returns 422" do
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "does not update the job" do
        expect(job.reload.title).not_to eq("")
      end

      it "returns validation errors" do
        expect(json_response.dig("errors", "title")).to be_present
      end
    end
  end

  describe "DELETE /api/v1/jobs/:id" do
    let!(:job) { create(:job, user: user) }

    before do
      delete api_v1_job_path(job.id), headers: headers
    end

    context "when user deletes own job" do
      it "returns 204" do
        expect(response).to have_http_status(:no_content)
      end

      it "returns no content" do
        expect(response.body).to be_blank
      end

      it "deletes the record" do
        expect(Job.find_by(id: job.id)).to be_nil
      end
    end

    context "when user tries to delete another user's job" do
      let(:another_user) { create(:user) }
      let!(:job) { create(:job, user: another_user) }

      it "returns 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "does not delete the record" do
        expect(Job.find_by(id: job.id)).not_to be_nil
      end
    end
  end
end
