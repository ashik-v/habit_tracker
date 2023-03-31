class HabitTrackerClient {
  constructor() {}

  async fetchHabits() {
    const query = { query: `query habits { habits { id name trackedDates } }` }
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

  async trackHabit(habitId, date) {
    const mutation = { query: `mutation trackDate { trackDate(input: { habitId: ${habitId} date: "${date}" }) { habit { name trackedDates } } }` }

    const response = await fetch("http://localhost:3002/graphql",
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(mutation),
      }
    )

    const habitResponse = await response.json()

    if (habitResponse.data.habit) {
      return true
    }
  }

  async untrackHabit(habitId, date) {
    const mutation = {
      query: `
      mutation untrackDate {
        untrackDate(
          input: {
            habitId: ${habitId}
            date: "${date}"
          }
        ) {
          habit {
            name
            trackedDates
          }
        }
      }
    ` }

    const response = await fetch("http://localhost:3002/graphql",
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(mutation),
      }
    )

    const habitResponse = await response.json()

    if (habitResponse.data.habit) {
      return true
    }
  }
}

export default HabitTrackerClient;
