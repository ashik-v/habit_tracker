module Mutations
  class CreateHabit < Mutations::BaseMutation
    # arguments (similar to Rails strong parameters)
    argument :name, String, required: true
    argument :tracked_dates, [GraphQL::Types::ISO8601Date]

    field :habit, Types::HabitType

    def resolve(name:, tracked_dates:)
      { habit: Habit.create(name: name, tracked_dates: tracked_dates, deprecated_tracked_dates: tracked_dates) }
    end
  end
end