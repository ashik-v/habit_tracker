module Types
  class HabitType < Types::BaseObject
    description "a habit"

    field :id, ID, null: false
    field :name, String
    field :tracked_dates, [GraphQL::Types::ISO8601Date]
  end
end
