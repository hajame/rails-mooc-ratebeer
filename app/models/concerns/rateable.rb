module Rateable
  def top(limit)
    includes(:ratings).all
                      .sort_by { |b| -b.average_rating }
                      .take(limit)
  end
end
