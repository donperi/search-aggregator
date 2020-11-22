import { render, screen, waitFor, fireEvent, act } from '@testing-library/react';
import Search from './Search';
import { createMemoryHistory } from 'history'
import { Router } from 'react-router-dom'
import * as searchTerm from '../../queries/searchTerm';
import { mockMediaQuery } from "../../spec_utils";

it('should show idle message if initial params are not valid', () => {
  const history = createMemoryHistory();
  render(
    <Router history={history}>
      <Search />
    </Router>
  );
  const linkElement = screen.getByText(/Use the form to perform a search./i);
  expect(linkElement).toBeInTheDocument();
});

it('should show result header after doing initial fetch if params are valid',  async () => {
  mockMediaQuery(true);

  searchTerm.default = jest.fn();
  searchTerm.default.mockResolvedValue({
    items: [],
    total: 0
  });

  const history = createMemoryHistory();
  history.push({
    pathname: '/search',
    search: '?term=ruby&engines[]=google'
  });

  render(
    <Router history={history}>
      <Search />
    </Router>
  );

  expect(searchTerm.default).toBeCalledWith('search', 'ruby', ['google'], 0)

  await waitFor(() => {
    const linkElement = screen.getByText(/Showing Results of: ruby/i);

    expect(linkElement).toBeInTheDocument();
  });
});

it ('should perform a search after submitting form', async () => {
  mockMediaQuery(true);

  searchTerm.default = jest.fn();
  searchTerm.default.mockResolvedValue({
    items: [],
    total: 0
  });

  const history = createMemoryHistory();
  history.push({
    pathname: '/search',
    search: ''
  });

  render(
    <Router history={history}>
      <Search />
    </Router>
  );

  expect(searchTerm.default).not.toBeCalled()

  const searchInput = screen.getByPlaceholderText('Search...');
  const enginesInput = screen.getByText('Engines');
  const submitButton = screen.getByText('Search');

  await act(async () => {
    fireEvent.change(searchInput, { target: { value: 'rubylang' }});
    fireEvent.click(enginesInput);

    const googleOption = await waitFor(() => screen.getByText('Google'));
    const bingOption = await waitFor(() => screen.getByText('Bing'));

    fireEvent.click(googleOption);
    fireEvent.click(bingOption);

    fireEvent.click(submitButton);
  });

  expect(history.location.search).toBe('?engines[]=google&engines[]=bing&term=rubylang');
  expect(searchTerm.default).toBeCalledWith('search', 'rubylang', ['google', 'bing'], 0)
})
