class Test < ApplicationRecord
  has_many :questions, dependent: :destroy

  def self.of_category(category)
    self.where(category_id: category.id).order(id: :desc)
  end
end
