class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :questions, dependent: :destroy
  has_many :attempts, dependent: :destroy
  has_many :users, through: :attempts

  def self.of_category(category_title)
    joins(:category)
      .where(categories: { title: category_title })
      .order(id: :desc)
      .pluck(:title)
  end
end
