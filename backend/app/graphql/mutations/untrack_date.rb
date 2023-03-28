module Mutations
  class UntrackDate < Mutations::BaseMutation
    argument :habit_id, GraphQL::Types::Int
    argument :date, GraphQL::Types::ISO8601Date

    field :habit, Types::HabitType

    def resolve(habit_id:, date:)
      habit = Habit.find(habit_id)
      tracked_dates = habit.tracked_dates
      tracked_dates.delete(date)
      habit.update!(tracked_dates: tracked_dates)

      {
        habit: habit
      }
    end
  end
end
