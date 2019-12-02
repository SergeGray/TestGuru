class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :questions, dependent: :destroy
  has_many :attempts, dependent: :destroy
  has_many :users, through: :attempts
  has_many :user_badges, through: :user_badge_tests
  has_many :user_badge_tests, dependent: :destroy

  validates :title, presence: true
  validates :level, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }, allow_nil: true
  validates :title, uniqueness: { scope: :level }

  scope :of_level, ->(level) { where(level: level) }
  scope :easy, -> { of_level(0..1) }
  scope :medium, -> { of_level(2..4) }
  scope :hard, -> { of_level(5..Float::INFINITY) }
  scope :of_category, (
    lambda do |category_id|
      joins(:category)
        .where(categories: { id: category_id })
        .order(id: :desc)
    end
  )

  def self.titles_of_category(category_title)
    of_category(category_title).pluck(:title)
  end
end
