import HabitTrackerClient from '../../lib/habitTrackerClient';

global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () => { return { "data": { "habits": [{ "name": "RUN" }, { "name": "Sleep early" }] }} },
  })
);

describe('fetchHabits', () => {
  it('returns a list of habits', async () => {
    const client = new HabitTrackerClient

    const habits = await client.fetchHabits()

    expect(habits).toEqual([{ name: "RUN"}, { name: "Sleep early" }])
  });
});

