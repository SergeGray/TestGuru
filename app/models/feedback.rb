class Feedback
  include ActiveModel::Model

  attr_accessor :email, :content, :id

  validates :content, presence: true
  validates :email, presence: true, format: {
    with: URI::MailTo::EMAIL_REGEXP
  } 
end
