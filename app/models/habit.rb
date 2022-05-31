class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.is_a?(Date)
      record.errors.add attribute, (options[:message] || "is not a date")
    end
  end
end

class Habit < ApplicationRecord
  serialize :tracked_dates, Array
  validate :tracked_dates_type

  def tracked_dates_type
    tracked_dates.each do |tracked_date|
      unless tracked_date.is_a?(Date)
        errors.add(:tracked_dates, "must only contain dates")
      end
    end
  end
end