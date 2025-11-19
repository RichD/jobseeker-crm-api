class Api::V1::JobsController < ApplicationController
  before_action :authorize_request # Authenticate all actions
  before_action :set_job, only: %i[update destroy] # Find job for update/delete

  def index
    render_response({ jobs: @current_user.jobs })
  end

  def create
    job = @current_user.jobs.build(job_params)

    if job.save
      render_response({ job: job }, status: :created)
    else
      job_error_response(job)
    end
  end

  def update
    if @job.update(job_params)
      render_response({ job: @job })
    else
      job_error_response(@job)
    end
  end

  def destroy
    @job.destroy
    head(:no_content)
  end

  private

  def set_job
    @job = @current_user.jobs.find_by(id: params[:id])

    error_response("Job not found", status: :not_found) unless @job
  end

  def job_params
    params
      .expect(
        job: %i[
          title company url location status description
          notes compensation applied_at
        ]
      )
  end

  def job_error_response(job)
    error_response(
      job.errors.to_hash(full_messages: true),
      status: :unprocessable_content
    )
  end
end
