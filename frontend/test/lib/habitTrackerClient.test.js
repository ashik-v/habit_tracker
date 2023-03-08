import HabitTrackerClient from '../../lib/habitTrackerClient';
import { enableFetchMocks } from 'jest-fetch-mock'

// TODO: Extract me to a config file.
// https://github.com/jefflau/jest-fetch-mock#package-installation
enableFetchMocks()

describe('fetchHabits', () => {
  it('returns a list of habits', async () => {
    const mockedResponse = { "data": { "habits": [{ "name": "RUN", "id": "1", "trackedDates": [] }, { "name": "Sleep early", id: "2", "trackedDates": ["2022-07-26", "2022-07-27"] }] }}
    fetch.mockResponseOnce(JSON.stringify(mockedResponse))
    const client = new HabitTrackerClient

    const habits = await client.fetchHabits()

    expect(habits).toEqual([{ id: "1", name: "RUN", "trackedDates": []}, { name: "Sleep early", id: "2", trackedDates: ["2022-07-26", "2022-07-27"] }])
  });
});
``
describe('trackHabit', () => {
  it('tracks a habit for a given date', async () => {
    const mockedResponse = { "data": { "habit": { "name": "Sleep early", id: "2", "trackedDates": ["2022-07-26", "2022-07-27"] }}}
    fetch.mockedResponseOnce(JSON.stringify(mockedResponse))
    const client = new HabitTrackerClient
    
    const result = await client.trackHabit(2, "2022-07-27")
    
    expect(result).toEqual(true)
  });
});
