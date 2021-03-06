class Question < ApplicationRecord
  default_scope { order(:id) }
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :gists

  validates :body, presence: true
end
