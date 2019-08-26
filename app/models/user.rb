class User < ApplicationRecord
  def started_by_level(level)
    Test.where(id: @visited).where(level: level)
  end
end
