class Feedback < ApplicationRecord
  validates :content, presence: true
  validates :email, presence: true, format: {
    with: URI::MailTo::EMAIL_REGEXP
  }
end
