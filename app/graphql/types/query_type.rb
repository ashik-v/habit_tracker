module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :habits, [HabitType], "get all habits"
    def habits
      Habit.all
    end

    field :habit, HabitType, "gets a specific habit" do
      argument :name, String
    end

    def habit(name:)
      Habit.find_by(name: name)
    end
  end
end
