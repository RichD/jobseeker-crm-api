require "rails_helper"

RSpec.describe "Api::V1::Jobs", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers_for(user) }

  describe "GET /api/v1/jobs" do
    context "without params" do
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

    context "with search param q" do
      let!(:senior_dev) do
        create(:job, user: user, title: "Senior Developer", company: "TechCo")
      end

      let!(:consulting_job) do
        create(:job, user: user, title: "Manager", company: "Consulting Group")
      end

      let!(:engineer_role) do
        create(
          :job,
          user: user,
          title: "Software Engineer",
          company: "Engineering Inc"
        )
      end

      it "returns jobs matching title" do
        get api_v1_jobs_path, headers: headers, params: { q: "Senior" }

        expect(json_response["jobs"].pluck("id")).to contain_exactly(senior_dev.id)
      end

      it "returns jobs matching company" do
        get api_v1_jobs_path, headers: headers, params: { q: "Consulting" }

        expect(json_response["jobs"].pluck("id")).to contain_exactly(consulting_job.id)
      end

      it "returns jobs matching title and/or company" do
        get api_v1_jobs_path, headers: headers, params: { q: "Engineer" }

        expect(json_response["jobs"].pluck("id")).to contain_exactly(engineer_role.id)
      end

      it "is case-insensitive" do
        get api_v1_jobs_path, headers: headers, params: { q: "senior" }

        expect(json_response["jobs"].pluck("id")).to contain_exactly(senior_dev.id)
      end
    end

    context "with filter params" do
      context "when filtering by status" do
        let!(:applied_job) { create(:job, user: user, status: :applied) }
        let(:params) { { status: "applied" } }

        before do
          create(:job, user: user, status: :saved)
          create(:job, user: user, status: :interviewing)
          get api_v1_jobs_path, headers: headers, params: { status: "applied" }
        end

        it "filters by status" do
          expect(json_response["jobs"].count).to eq(1)
          expect(json_response["jobs"].first["id"]).to eq(applied_job.id)
        end
      end

      context "when filtering by location (remote)" do
        let!(:remote_job) { create(:job, user: user, location: "Remote") }

        before do
          create(:job, user: user, location: "San Diego, CA")

          get api_v1_jobs_path,
              headers: headers,
              params: { location: "remote" }
        end

        it "filters by location (case-insensitive)" do
          expect(json_response["jobs"].size).to eq(1)
          expect(json_response["jobs"].first["id"]).to eq(remote_job.id)
        end
      end

      context "when filtering by location (San Diego)" do
        let!(:san_diego_job) do
          create(:job, user: user, location: "San Diego, CA")
        end

        let!(:san_diego_county_job) do
          create(:job, user: user, location: "San Diego County")
        end

        before do
          create(:job, user: user, location: "Remote")

          get api_v1_jobs_path,
              headers: headers,
              params: { location: "San Diego" }
        end

        it "filters by location (partial match)" do
          expect(json_response["jobs"].size).to eq(2)
          expect(json_response["jobs"].map { |j| j["id"] })
            .to contain_exactly(san_diego_job.id, san_diego_county_job.id)
        end
      end

      context "when filtering by applied_at range" do
        let!(:recent_app) { create(:job, user: user, applied_at: 1.week.ago) }
        let!(:old_app) { create(:job, user: user, applied_at: 3.months.ago) }

        before do
          create(:job, user: user, applied_at: nil)
          get api_v1_jobs_path, headers: headers, params: params
        end

        context "with only applied_from" do
          let(:params) { { applied_from: 2.months.ago.to_date } }

          it "returns jobs newer than applied_from" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to contain_exactly(recent_app.id)
          end
        end

        context "with only applied_to" do
          let(:params) { { applied_to: 2.months.ago.to_date } }

          it "returns jobs older than applied_to" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to contain_exactly(old_app.id)
          end
        end

        context "with applied_from and applied_to" do
          let(:params) do
            {
              applied_from: 4.months.ago.to_date,
              applied_to: 1.day.ago.to_date
            }
          end

          it "returns jobs between applied_from and applied_to" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to contain_exactly(old_app.id, recent_app.id)
          end
        end
      end
    end

    context "with sort params" do
      context "when sorting by created_at" do
        let!(:newest) { create(:job, user: user, created_at: 1.day.ago) }
        let!(:oldest) { create(:job, user: user, created_at: 3.weeks.ago) }

        before do
          get api_v1_jobs_path, headers: headers, params: params
        end

        context "without order param" do
          let(:params) { { sort_by: "created_at" } }

          it "sorts descending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([newest.id, oldest.id])
          end
        end

        context "with order asc" do
          let(:params) { { sort_by: "created_at", order: "asc" } }

          it "sorts ascending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([oldest.id, newest.id])
          end
        end

        context "with order desc" do
          let(:params) { { sort_by: "created_at", order: "desc" } }

          it "sorts descending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([newest.id, oldest.id])
          end
        end
      end

      context "when sorting by applied_at" do
        let!(:newest_app) { create(:job, user: user, applied_at: 1.day.ago) }
        let!(:oldest_app) { create(:job, user: user, applied_at: 3.weeks.ago) }

        before do
          get api_v1_jobs_path, headers: headers, params: params
        end

        context "without order param" do
          let(:params) { { sort_by: "applied_at" } }

          it "sorts descending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([newest_app.id, oldest_app.id])
          end
        end

        context "with order asc" do
          let(:params) { { sort_by: "applied_at", order: "asc" } }

          it "sorts ascending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([oldest_app.id, newest_app.id])
          end
        end

        context "with order desc" do
          let(:params) { { sort_by: "applied_at", order: "desc" } }

          it "sorts descending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([newest_app.id, oldest_app.id])
          end
        end
      end

      context "when sorting by title" do
        let!(:associate) { create(:job, user: user, title: "Associate") }
        let!(:zen_master) { create(:job, user: user, title: "Zen Master") }

        before do
          get api_v1_jobs_path, headers: headers, params: params
        end

        context "without order param" do
          let(:params) { { sort_by: "title" } }

          it "sorts ascending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([associate.id, zen_master.id])
          end
        end

        context "with order desc" do
          let(:params) { { sort_by: "title", order: "desc" } }

          it "sorts descending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([zen_master.id, associate.id])
          end
        end

        context "with order asc" do
          let(:params) { { sort_by: "title", order: "asc" } }

          it "sorts ascending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([associate.id, zen_master.id])
          end
        end
      end

      context "when sorting by company" do
        let!(:armadillo) { create(:job, user: user, company: "Armadillo Inc") }
        let!(:zebra) { create(:job, user: user, company: "Zebra LLC") }

        before do
          get api_v1_jobs_path, headers: headers, params: params
        end

        context "without order param" do
          let(:params) { { sort_by: "company" } }

          it "sorts ascending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([armadillo.id, zebra.id])
          end
        end

        context "with order desc" do
          let(:params) { { sort_by: "company", order: "desc" } }

          it "sorts descending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([zebra.id, armadillo.id])
          end
        end

        context "with order asc" do
          let(:params) { { sort_by: "company", order: "asc" } }

          it "sorts ascending" do
            expect(json_response["jobs"].map { |j| j["id"] })
              .to eq([armadillo.id, zebra.id])
          end
        end
      end
    end

    context "with pagination params" do
      before do
        Array.new(25) do |i|
          create(
            :job,
            user: user,
            title: "Job #{i + 1}",
            created_at: i.minutes.ago
          )
        end

        get api_v1_jobs_path,
            headers: headers,
            params: { page: 3, per_page: 10 }
      end

      it "limits results to per_page" do
        expect(json_response["jobs"].count).to eq(5)
      end

      it "returns result based on page offset" do
        expect(json_response["jobs"].first["title"]).to eq("Job 21")
      end

      it "returns total count" do
        expect(json_response.dig("pagination", "total_count")).to eq(25)
      end
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
