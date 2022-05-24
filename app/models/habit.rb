class Habit < ApplicationRecord
  serialize :tracked_dates, Array
end
