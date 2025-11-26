class Api::V1::JobsController < ApplicationController
  include Pagy::Method

  PER_PAGE = 10

  before_action :authorize_request
  before_action :set_job, only: %i[show update destroy]
  before_action :set_jobs, only: :index

  def index
    render_response(
      {
        jobs: @jobs,
        pagination: {
          current_page: @pagy.page,
          per_page: @pagy.limit,
          total_count: @pagy.count,
          total_pages: @pagy.last
        }
      }
    )
  end

  def show
    render_response({ job: @job }, status: :ok)
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

  def search_jobs
    if params[:q]
      search = "%#{Job.sanitize_sql_like(params[:q])}%"
      @jobs = @jobs.where("title ILIKE ? OR company ILIKE ?", search, search)
    end

    return unless params[:location]

    location = "%#{Job.sanitize_sql_like(params[:location])}%"
    @jobs = @jobs.where("location ILIKE ?", location)
  end

  def filter_jobs
    @jobs = @jobs.where(status: params[:status]) if params[:status]

    @jobs = @jobs.where(applied_at: ..params[:applied_to]) if
      params[:applied_to]

    @jobs = @jobs.where(applied_at: params[:applied_from]..) if
      params[:applied_from]
  end

  def sort_jobs
    return unless params[:sort_by]

    sort_order =
      params[:order] ||
      if %w[created_at applied_at].include?(params[:sort_by])
        :desc
      else
        :asc
      end

    @jobs = @jobs.order(params[:sort_by] => sort_order)
  end

  def set_jobs
    @jobs = @current_user.jobs

    search_jobs
    filter_jobs
    sort_jobs

    # pagination
    @pagy, @jobs =
      pagy(:offset, @jobs, limit: (params[:per_page] ||= PER_PAGE))
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
