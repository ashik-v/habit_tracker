class HabitTrackerClient {
  constructor() {}

  async fetchHabits() {
    const query = { query: `{ habits { name } }` }
    const response = await fetch(
      "http://localhost:3002/graphql",
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(query),
      })
    const habitResponse = await response.json()

    return habitResponse.data.habits
  }
}

export default HabitTrackerClient;
