require 'rails_helper'

RSpec.describe Habit, type: :model do
  it "scopes by date" do
    habit = Habit.create(name: "habit", tracked_dates: [Date.today])
    another_habit = Habit.create(name: "another habit", tracked_dates: [Date.yesterday, Date.today])
    Habit.create(name: "irrelevant habit", tracked_dates: [])

    result = Habit.by_date(Date.today)

    expect(result).to contain_exactly(habit, another_habit)
  end

  it "accepts date values for tracked dates" do
    habit = Habit.new(name: "new habit", tracked_dates: [Date.today])

    expect(habit).to be_valid
  end

  it "rejects non-date values for tracked dates" do
    habit = Habit.new(name: "new habit", tracked_dates: ["01/01/2030"])

    expect(habit).to_not be_valid
  end

  it "does not duplicate errors with multiple non-date inputs" do
    habit = Habit.new(name: "new habit", tracked_dates: ["01/01/2030", "02/01/2030"])

    expect(habit).to_not be_valid
    expect(habit.errors.full_messages).to contain_exactly('Tracked dates must only contain dates. Invalid dates provided: ["01/01/2030", "02/01/2030"]')
  end

  it "does not take the same date twice" do
    habit = Habit.new(name: "new habit", tracked_dates: [Date.today, Date.today])

    habit.save

    expect(habit).to_not be_valid
    expect(habit.errors.full_messages).to contain_exactly("Tracked dates must not contain duplicate dates.")
  end
end
