class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, presence: true
  validates :image_url, presence: true
  validates :condition, presence: true,
                        uniqueness: { scope: :condition_value },
                        inclusion: {
                          in: BadgeAwardService::CONDITIONS,
                          message: :invalid_condition
                        }
  validates :condition_value, presence: true
end
