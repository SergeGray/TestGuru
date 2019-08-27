class Test < ApplicationRecord
  # has_many :questions, dependent: :destroy
  # has_many :attempts
  # has_many :users, through: :attempts
  # belongs_to :category

  def self.of_category(category_title)
    where(
      category_id: Category.find_by!(title: category_title).id
    ).order(id: :desc).pluck(:title)
  end
end
