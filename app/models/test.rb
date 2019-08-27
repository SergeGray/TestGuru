class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :attempts
  has_many :users, through: :attempts
  belongs_to :category

  def self.of_category(category)
    self.where(category_id: category.id).order(id: :desc)
  end
end
