class Api::V1::JobSkillsController < ApplicationController
  before_action :authorize_request
  before_action :set_job
  before_action :set_job_skill, only: :destroy

  def index
    params[:suggest] ? suggest_skills : list_skills
  end

  def create
    job_skills, errors = parse_skill_params

    if errors.empty?
      job_skills.each(&:save!)

      render_response(
        { job_skills: job_skills.map { |js| job_skill_json(js) } },
        status: :created
      )
    else
      error_response(errors, status: :unprocessable_content)
    end
  end

  def destroy
    @job_skill.destroy
    head :no_content
  end

  private

  def set_job
    @job = @current_user.jobs.find_by(id: params[:job_id])
    error_response("Job not found", status: :not_found) unless @job
  end

  def set_job_skill
    @job_skill = @job.job_skills.find_by(id: params[:id])
    error_response("Job skill not found", status: :not_found) unless @job_skill
  end

  def suggest_skills
    skills = SkillExtractorService.extract(@job.description || "")
    render_response({ suggested_skills: skills.map { |s| skill_json(s) } })
  end

  def skill_json(skill)
    {
      id: skill.id,
      name: skill.name,
      slug: skill.slug,
      category: skill.category,
      aliases: skill.aliases
    }
  end

  def job_skill_json(job_skill)
    {
      id: job_skill.id,
      skill: skill_json(job_skill.skill),
      years_required: job_skill.years_required,
      classification: job_skill.classification
    }
  end

  def list_skills
    job_skills = @job.job_skills.includes(:skill)

    render_response({ skills: job_skills.map { |js| job_skill_json(js) } })
  end

  def skill_params
    params.permit(
      :job_id, skills: %i[skill_id years_required classification]
    )
  end

  def parse_skill_params
    job_skills = []
    errors = []

    skill_params[:skills].each do |skill_data|
      job_skill = @job.job_skills.build(skill_data)

      if job_skill.valid?
        job_skills << job_skill
      else
        errors << {
          skill_id: skill_data[:skill_id],
          errors: job_skill.errors.full_messages
        }
      end
    end

    [job_skills, errors]
  end
end
