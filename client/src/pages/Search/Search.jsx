import { useCallback } from 'react';
import qs from 'query-string';
import {
  Container,
  Divider,
  Dimmer,
  Loader,
  Grid,
  Header, Button
} from 'semantic-ui-react';
import { useLocation, useHistory } from 'react-router-dom';
import { useQuery } from 'react-query'
import searchTerm from "../../queries/searchTerm";
import SearchResult from "../../components/SearchResult/SearchResult";
import SearchForm from "../../components/SearchForm/SearchForm";
import useSearchParams from "../../hooks/useSearchParams";
import usePushSearchParams from "../../hooks/usePushSearchParams";

const Search = () => {
  const { push } = useHistory();
  const params = useSearchParams();

  const {
    isLoading,
    isError,
    isFetched,
    data
  } = useQuery(['search', params.term, params.engines, params.offset], searchTerm, {
    enabled: params.term && params.engines
  });

  const pushSearchParams = usePushSearchParams();

  const onSubmitSearch = useCallback((data) => {
    pushSearchParams({
      ...data
    });
  }, [push])

  return (
    <>
      <Container fluid>
        <SearchForm
          values={params}
          onSubmit={onSubmitSearch}
        />

        <Divider />

        {!isFetched && !isLoading && (
          <Grid centered padded>
            <Grid.Column>
              <Header textAlign={"center"}>Use the form to perform a search.</Header>
            </Grid.Column>
          </Grid>
        )}

        {isLoading && (
          <Dimmer active inverted>
            <Loader inverted>Loading</Loader>
          </Dimmer>
        )}

        {isFetched && !isLoading && !isError && (<SearchResult term={params.term} items={data.items} />)}
      </Container>
    </>
  )
}

export default Search;
