module Types
  class MutationType < Types::BaseObject
    field :create_habit, mutation: Mutations::CreateHabit,
      description: "Create habit"
  end
end
