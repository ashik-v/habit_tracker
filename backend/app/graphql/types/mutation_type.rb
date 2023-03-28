module Types
  class MutationType < Types::BaseObject
    field :create_habit, mutation: Mutations::CreateHabit,
      description: "Create habit"
    field :track_date, mutation: Mutations::TrackDate,
          description: "Track a date for a specified habit"
    field :untrack_date, mutation: Mutations::UntrackDate,
          description: "Untrack a date for a specified habit"
  end
end
