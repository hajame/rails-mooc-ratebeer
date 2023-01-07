module Rateable
  def top(limit)
    all.sort_by { |b| -b.average_rating }.take(limit)
  end
end
