class Job < ApplicationRecord
  belongs_to :user

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
