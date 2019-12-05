class Badge < ApplicationRecord
  enum condition: {
    first_try: 0,
    all_with_level: 1,
    all_in_category: 2,
    perfect_score: 3
  }
  
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, presence: true
  validates :image_url, presence: true
  validates :condition, presence: true
  validates :condition_value, presence: true
end
