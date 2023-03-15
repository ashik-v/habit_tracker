import HabitTrackerClient from '../../lib/habitTrackerClient';

describe('HabitTrackerClient', () => {
  fetch = jest.fn()

  describe('fetchHabits', () => {
    it('returns a list of habits', async () => {
      const mockedResponse = { data: { habits: [{ name: "RUN", id: "1", trackedDates: [] }, { name: "Sleep early", id: "2", trackedDates: ["2022-07-26", "2022-07-27"] }] }}
      fetch.mockReturnValueOnce({ json: () => mockedResponse })
      const client = new HabitTrackerClient

      const habits = await client.fetchHabits()

      expect(habits).toEqual([{ id: "1", name: "RUN", trackedDates: []}, { name: "Sleep early", id: "2", trackedDates: ["2022-07-26", "2022-07-27"] }])
    });
  });

  describe('trackHabit', () => {
    it('tracks a habit for a given date', async () => {
      const mockedResponse = { data: { habit: { name: "Sleep early", id: "2", trackedDates: ["2022-07-26", "2022-07-27"] }}}
      fetch.mockReturnValueOnce({ json: () => mockedResponse })
      const client = new HabitTrackerClient

      const result = await client.trackHabit(2, "2022-07-27")

      expect(result).toEqual(true)
    });

    it('calls the api using fetch', async () => {
      fetch.mockReturnValue({
        json: () => {
          return { data: { habit: "results" } }
        }
      })
      const client = new HabitTrackerClient

      await client.trackHabit(2, "2022-07-27")

      const mutation = { mutation: `
      {
        trackDate(
          input: {
            habitId: 2
            date: "2022-07-27"
          }
        ) {
          habit {
            name
            trackedDates
          }
        }
      }
    ` }

      expect(fetch).toBeCalledWith("http://localhost:3002/graphql",
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(mutation),
        })
    });
  });

  describe('untrackHabit', () => {
    it('untracks a habit for a given date', async () => {
      const mockedResponse = { data: { habit: { name: "Sleep early", id: "2", trackedDates: ["2022-07-26"] }}}
      fetch.mockReturnValueOnce({
        json: () => mockedResponse
      })
      const client = new HabitTrackerClient

      const result = await client.untrackHabit(2, "2022-07-27")

      expect(result).toEqual(true)
    });

    it('calls the api using fetch', async () => {
      fetch.mockReturnValueOnce({
        json: () => {
          return { data: { habit: "results" } }
        }
      })
      const client = new HabitTrackerClient

      await client.untrackHabit(2, "2022-07-27")

      const mutation = { mutation: `
      {
        untrackDate(
          input: {
            habitId: 2
            date: "2022-07-27"
          }
        ) {
          habit {
            name
            trackedDates
          }
        }
      }
    ` }

      expect(fetch).toBeCalledWith("http://localhost:3002/graphql",
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(mutation),
        })
    });
  });
});
