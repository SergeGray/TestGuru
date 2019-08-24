class AddNullConstraintToVariousAttributes < ActiveRecord::Migration[5.2]
  def change
    [
      [:tests, :title],
      [:questions, :body],
      [:answers, :body],
      [:users, :name],
      [:categories, :title],
    ].each { |table, column| change_column_null table, column, false }
  end
end
