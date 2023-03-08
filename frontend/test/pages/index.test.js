import Home from '../../pages/index'
import { enableFetchMocks } from 'jest-fetch-mock'
import { render } from '@testing-library/react';
import {act} from "react-dom/test-utils";

// TODO: Extract me to a config file.
// https://github.com/jefflau/jest-fetch-mock#package-installation
enableFetchMocks()

describe('Home', () => {
  it('renders correctly', async () => {
    const mockedResponse = { "data": { "habits": [{ "name": "RUN", "id": "1", "trackedDates": [] }, { "name": "Sleep early", id: "2", "trackedDates": ["2022-07-26", "2022-07-27"] }] }}
    fetch.mockResponseOnce(JSON.stringify(mockedResponse))
    let page;

    act(() => {
      page = render(<Home />)
    })

    expect(page).toMatchSnapshot();
  });
});
