import HabitTrackerClient from '../../lib/habitTrackerClient';
import { enableFetchMocks } from 'jest-fetch-mock'

// TODO: Extract me to a config file.
// https://github.com/jefflau/jest-fetch-mock#package-installation
enableFetchMocks()

describe('fetchHabits', () => {
  it('returns a list of habits', async () => {
    const mockedResponse = { "data": { "habits": [{ "name": "RUN" }, { "name": "Sleep early" }] }}
    fetch.mockResponseOnce(JSON.stringify(mockedResponse))
    const client = new HabitTrackerClient

    const habits = await client.fetchHabits()

    expect(habits).toEqual([{ name: "RUN"}, { name: "Sleep early" }])
  });
});

