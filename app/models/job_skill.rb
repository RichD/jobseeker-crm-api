class JobSkill < ApplicationRecord
  belongs_to :job
  belongs_to :skill

  validates :classification, inclusion: { in: %w[required preferred mentioned] }
  validates :skill_id, uniqueness: { scope: :job_id }
end
