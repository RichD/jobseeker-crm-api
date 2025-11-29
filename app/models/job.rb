class Job < ApplicationRecord
  belongs_to :user
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills

  enum :status, {
    saved: 0,
    applied: 1,
    interviewing: 2,
    offer: 3,
    rejected: 4
  }

  validates :title, presence: true
  validates :company, presence: true
  validates :status, presence: true
  validates :url,
            format: {
              with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
              allow_blank: true
            }
end
