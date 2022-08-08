module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :habits, [HabitType], "get all habits"

    def habits
      Habit.all
    end

    field :habit, HabitType, "gets a specific habit" do
      argument :name, String, required: false
      argument :id, ID, required: false
    end

    def habit(args)
      Habit.find_by(args)
    end

    field :habits_by_date, [HabitType], "get habits by a tracked date" do
      argument :tracked_date, GraphQL::Types::ISO8601Date, required: false
    end

    def habits_by_date(tracked_date:)
      Habit.by_date(tracked_date)
    end
  end
end
