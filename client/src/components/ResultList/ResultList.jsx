import { Card, Grid, Header } from 'semantic-ui-react'
import propTypes from 'prop-types';

import ResultItem from "../ResultItem/ResultItem";

const ResultList = ({ items }) => {
  if (!items.length) {
    return (
      <Grid>
        <Grid.Column textAlign={"center"}>
          <Header>No results.</Header>
        </Grid.Column>
      </Grid>
    )
  }

  return (
    <Card.Group>
      {items.map(i => <ResultItem key={`${i.source}-${i.url}`} {...i} />)}
    </Card.Group>
  )
};

ResultList.propTypes = {
  items: propTypes.array,
};

export default ResultList;
