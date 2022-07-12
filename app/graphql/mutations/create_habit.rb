module Mutations
  class CreateHabit < Mutations::BaseMutation
    # arguments (similar to Rails strong parameters)
    argument :name, String, required: true
    argument :tracked_dates, [GraphQL::Types::ISO8601Date], required: true

    # fields
    # field :habit, Types::HabitType
    field :name, String

    # resolve
    def resolve(*args)
      Habit.create(args)
    end
  end
end