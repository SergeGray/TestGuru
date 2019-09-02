class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :questions, dependent: :destroy
  has_many :attempts, dependent: :destroy
  has_many :users, through: :attempts

  validates :title, presence: true
  validates :level, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }, allow_nil: true
  validate :validate_unique_title_level

  scope :of_level, ->(level) { where(level: level) }
  scope :easy, -> { of_level(0..1) }
  scope :medium, -> { of_level(2..4) }
  scope :hard, -> { of_level(5..Float::INFINITY) }
  scope :of_category, (
    lambda do |category_title|
      joins(:category)
        .where(categories: { title: category_title })
        .order(id: :desc)
        .pluck(:title)
    end
  )

  private

  def validate_unique_title_level
    return unless self.class.where(title: title).pluck(:level).include?(level)

    errors.add(:base, "already exists with same name and level")
  end
end
