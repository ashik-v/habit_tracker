require 'rails_helper'

RSpec.describe Mutations::UntrackDate, type: :request do
  it "works" do
    habit = Habit.create!(name: "habit", tracked_dates: [Date.parse("2023-01-01"), Date.parse("2023-01-02"), Date.parse("2023-01-03")])
    gql = <<~GRAPHQL
      mutation {
        untrackDate(
          input: {
            habitId: #{habit.id}
            date: "2023-01-02"
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

    expect(habit.reload.tracked_dates).to contain_exactly(
                                            Date.parse("2023-01-01"),
                                            Date.parse("2023-01-03")
                                          )
  end
end
