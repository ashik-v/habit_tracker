module Mutations
  class TrackDate < Mutations::BaseMutation
    argument :habit_id, GraphQL::Types::Int
    argument :date, GraphQL::Types::ISO8601Date

    field :habit, Types::HabitType

    def resolve(habit_id:, date:)
      habit = Habit.find(habit_id)
      habit.tracked_dates << date
      habit.save!

      {
        habit: habit
      }
    end
  end
end
