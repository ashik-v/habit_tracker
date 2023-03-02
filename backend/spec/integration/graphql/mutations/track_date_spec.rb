require 'rails_helper'

RSpec.describe Mutations::TrackDate, type: :request do
  it "works " do
    habit = Habit.create(name: "habit")
    gql = <<~GRAPHQL
      mutation {
        trackDate(
          input: {
            habitId: #{habit.id}
            date: "2023-01-01"
          }
        ) {
          habit {
            name
            trackedDates
          }
        }
      }
    GRAPHQL

    post "/graphql", params: { query: gql }

    expect(habit.reload.tracked_dates).to include(Date.parse("2023-01-01"))
  end
end
