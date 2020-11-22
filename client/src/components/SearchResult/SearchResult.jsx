import {useMediaQuery} from "@react-hook/media-query";
import {useEffect, useState} from "react";
import propTypes from 'prop-types';
import {Button, Grid, Header} from "semantic-ui-react";

import ResultList from "../ResultList/ResultList";
import useSearchParams from "../../hooks/useSearchParams";
import usePushSearchParams from "../../hooks/usePushSearchParams";

const SearchResult = ({ term, items }) => {
  const isLarge = useMediaQuery('(min-width: 700px)')
  const searchParams = useSearchParams();

  const [collection, setCollection] = useState({
    'Google and Bing': items
  })

  useEffect(() => {
    if (isLarge) {
      setCollection(items.reduce((carry, item) => {
        if (!carry[item.source]) {
          carry[item.source] = [];
        }

        carry[item.source].push(item)
        return carry;
      }, {}))
    } else {
      setCollection({
        'Google and Bing': items
      })
    }
  }, [items, isLarge]);

  const pushSearchParams = usePushSearchParams();

  const changePage = (num) => {
    pushSearchParams({
      ...searchParams,
      offset: searchParams.offset + num
    });
  }

  return (
    <>
      <Grid padded>
        <Grid.Column>
          <Header as={"h3"}>
            Showing Results of: {term}
          </Header>
        </Grid.Column>
      </Grid>

      <Grid padded celled='internally' columns={isLarge ? 2 : 1} relaxed={"very"}>
        {Object.keys(collection).map(key => (
          <Grid.Column key={key}>
            <Header as={"h3"} className={'capitalize'}>{key}</Header>
            <ResultList items={collection[key]} />
          </Grid.Column>
        ))}
      </Grid>

      <Grid padded centered column={1}>
        <Grid.Column textAlign={"center"}>
          <Button disabled={searchParams.offset === 0} onClick={() => changePage(-10)}>Prev</Button>
          <Button onClick={() => changePage(10)}>Next</Button>
        </Grid.Column>
      </Grid>
    </>
  )
}

SearchResult.propTypes = {
  term: propTypes.string,
  items: propTypes.array,
}

export default SearchResult;
