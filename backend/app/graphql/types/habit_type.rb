module Types
  class HabitType < Types::BaseObject
    description "a habit"

    field :id, ID, null: false
    field :name, String
    field :tracked_dates, [GraphQL::Types::ISO8601Date]

    def tracked_dates
      Object.deprecated_tracked_dates
    end
  end
end
