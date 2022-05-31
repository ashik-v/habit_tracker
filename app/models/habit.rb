class Habit < ApplicationRecord
  serialize :tracked_dates, Array
  validate :tracked_dates_type

  def tracked_dates_type
    invalid_dates = []
    tracked_dates.each do |tracked_date|
      unless tracked_date.is_a?(Date)
        invalid_dates << tracked_date
      end
    end
    errors.add(:tracked_dates, "must only contain dates. Invalid dates provided: #{invalid_dates}") if invalid_dates.any?
  end
end