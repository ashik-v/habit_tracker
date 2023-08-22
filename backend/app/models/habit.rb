class Habit < ApplicationRecord
  serialize :tracked_dates, Array
  serialize :deprecated_tracked_dates, Array
  validate :tracked_dates_type, :tracked_dates_uniqueness
  validate :deprecated_tracked_dates_type, :deprecated_tracked_dates_uniqueness
  validates :name, presence: true
  scope :by_date, ->(date) { Habit.all.select{ |habit| habit.deprecated_tracked_dates.include?(date) } }

  ## This implements the scope as a class method; commented for posterity
  # def self.by_date(date)
  #   Habit.where('tracked_dates LIKE ?', "%#{date.to_s}%")
  # end

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

  def deprecated_tracked_dates_type
    invalid_dates = []
    deprecated_tracked_dates.each do |tracked_date|
      unless tracked_date.is_a?(Date)
        invalid_dates << tracked_date
      end
    end
    errors.add(:deprecated_tracked_dates, "must only contain dates. Invalid dates provided: #{invalid_dates}") if invalid_dates.any?
  end

  def deprecated_tracked_dates_uniqueness
    errors.add(:deprecated_tracked_dates, "must not contain duplicate dates.") unless deprecated_tracked_dates.uniq == deprecated_tracked_dates
  end
end