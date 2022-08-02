module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

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
  end
end
