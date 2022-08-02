require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe "habits query" do
    it "queries all habits" do
      habit = Habit.create(name: "sleep on time", tracked_dates: [])
      another_habit = Habit.create(name: "moisturize", tracked_dates: [Date.parse("2022-07-26")])

      habits_query = <<~GRAPHQL
        query {
          habits {
            name
            trackedDates
          }
        }
      GRAPHQL
      post "/graphql", params: { query: habits_query }

      result = JSON.parse(response.body)
      expected_result = { "data" => { "habits" => [ { "name" => habit.name, "trackedDates" => habit.tracked_dates }, { "name" => another_habit.name, "trackedDates" => another_habit.tracked_dates.map(&:to_s) } ] } }
      expect(result).to eq(expected_result)
      expect(response).to be_successful
    end
  end

  describe "queries a habit" do
    it "by name" do
      habit = Habit.create(name: "sleep on time", tracked_dates: [])

      habits_query = <<~GRAPHQL
        query {
          habit(name: "sleep on time") {
            name
            trackedDates
          }
        }
      GRAPHQL
      post "/graphql", params: { query: habits_query }

      result = JSON.parse(response.body)
      expected_result = { "data" => { "habit" => { "name" => habit.name, "trackedDates" => habit.tracked_dates } } }
      expect(result).to eq(expected_result)
      expect(response).to be_successful
    end

    it "by id" do
      habit = Habit.create(name: "sleep on time", tracked_dates: [])

      habits_query = <<~GRAPHQL
        query {
          habit(id: #{habit.id}) {
            name
            trackedDates
          }
        }
      GRAPHQL
      post "/graphql", params: { query: habits_query }

      result = JSON.parse(response.body)
      expected_result = { "data" => { "habit" => { "name" => habit.name, "trackedDates" => habit.tracked_dates } } }
      expect(result).to eq(expected_result)
      expect(response).to be_successful
    end
  end
end
