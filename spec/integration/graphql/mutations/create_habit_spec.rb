require 'rails_helper'

RSpec.describe Mutations::CreateHabit, type: :request do
  it "creates a habit" do
    create_habit
    habit = Habit.last
    parsed_habit_name = JSON.parse(response.body)["data"]["createHabit"]["habit"]["name"]

    expect(response).to be_successful
    expect(parsed_habit_name).to eq("Brush teeth")
    expect(habit).to have_attributes(
      name: "Brush teeth",
      tracked_dates: [Date.parse("2022-07-15"), Date.parse("2022-07-19")]
    )
  end

  def create_habit
    attributes = {
      name: "Brush teeth",
      tracked_dates: ["2022-07-15", "2022-07-19"]
    }

    mutation = <<~GRAPHQL
      mutation {
        createHabit(
          input: {
            #{attributes.map { |k, v| %(#{k.to_s.camelize(:lower)}: #{v.to_json}) }.join("\n    ")}
          }
        ) {
          habit {
            name
          }
        }
      }
    GRAPHQL

    post "/graphql", params: { query: mutation }
  end
end
