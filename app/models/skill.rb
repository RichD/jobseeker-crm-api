class Skill < ApplicationRecord
  has_many :job_skills, dependent: :destroy
  has_many :jobs, through: :job_skills

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :category, inclusion: {
    in: %w[language framework database tool cloud methodology soft_skill]
  }

  before_validation :generate_slug, if: -> { slug.blank? }

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
