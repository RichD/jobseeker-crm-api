class User < ApplicationRecord
  has_secure_password
  has_many :jobs, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: :password_digest_changed?

  before_save :downcase_email

  private

  def downcase_email
    self.email = email&.downcase
  end
end
