import { Card, Label } from 'semantic-ui-react'
import propTypes from 'prop-types';

const ResultItem = ({ title, description, url, source }) => {
  return (
    <Card fluid>
      <Card.Content>
        <Card.Header>
          <a href={url} title={title} target="_blank">{title}</a>
        </Card.Header>
        <Card.Meta>
          <span>{url}</span>
        </Card.Meta>
        <Card.Description>{description}</Card.Description>
      </Card.Content>
    </Card>
  )
};

ResultItem.propTypes = {
  title: propTypes.string,
  source: propTypes.string,
  url: propTypes.string,
  description: propTypes.string,
};

export default ResultItem;
