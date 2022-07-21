module Mutations
  class CreateHabit < Mutations::BaseMutation
    # arguments (similar to Rails strong parameters)
    argument :name, String, required: true
    argument :tracked_dates, [GraphQL::Types::ISO8601Date]

    field :habit, Types::HabitType

    def resolve(args)
      { habit: Habit.create(args) }
    end
  end
end