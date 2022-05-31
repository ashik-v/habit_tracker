require 'rails_helper'

RSpec.describe Habit, type: :model do
  it "accepts date values for tracked dates" do
    habit = Habit.new(name: "new habit", start_date: Date.today, tracked_dates: [Date.today])

    expect(habit).to be_valid
  end

  it "rejects non-date values for tracked dates" do
    habit = Habit.new(name: "new habit", start_date: Date.today, tracked_dates: ["01/01/2030"])

    expect(habit).to_not be_valid
  end
end
