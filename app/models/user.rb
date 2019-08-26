class User < ApplicationRecord
  def started_by_level(level)
    Test.where(id: @started).where(level: level)
  end
end
