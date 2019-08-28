class Test < ApplicationRecord
  # has_many :questions, dependent: :destroy
  # has_many :attempts
  # has_many :users, through: :attempts
  # belongs_to :category

  def self.of_category(category_title)
    joins(
      "JOIN categories ON categories.id = tests.category_id"
    ).where(
      categories: { title: category_title }
    ).order(id: :desc).pluck(:title)
  end
end
