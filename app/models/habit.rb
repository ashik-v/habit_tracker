class Habit < ApplicationRecord
  serialize :tracked_dates, Array
  validate :tracked_dates_type, :tracked_dates_uniqueness
  validate :name, presence: true

  def tracked_dates_type
    invalid_dates = []
    tracked_dates.each do |tracked_date|
      unless tracked_date.is_a?(Date)
        invalid_dates << tracked_date
      end
    end
    errors.add(:tracked_dates, "must only contain dates. Invalid dates provided: #{invalid_dates}") if invalid_dates.any?
  end

  def tracked_dates_uniqueness
    errors.add(:tracked_dates, "must not contain duplicate dates.") unless tracked_dates.uniq == tracked_dates
  end
end