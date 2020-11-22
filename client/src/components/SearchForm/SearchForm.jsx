import {Controller, useForm} from "react-hook-form";
import propTypes from 'prop-types';

import {Button, Dropdown, Grid, Header, Input} from "semantic-ui-react";

const options = [
  { key: 'google', text: 'Google', value: 'google' },
  { key: 'bing', text: 'Bing', value: 'bing' },
];

const SearchForm = ({ onSubmit, values }) => {
  const { handleSubmit, errors, control } = useForm({
    defaultValues: {
      term: values.term || '',
      engines: values.engines || []
    }
  });

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Grid padded className={'mb-10'}>
        <Grid.Column mobile={16}>
          <Header as={"h1"}>Search Aggregator</Header>
        </Grid.Column>

        <Grid.Column computer={5} tablet={5} largeScreen={3} mobile={16}>
          <Controller
            name="term"
            control={control}
            rules={{
              required: true
            }}
            render={({ onChange, onFocus, value, name }) => (
              <Input
                error={!!errors[name]}
                name={name}
                onChange={onChange}
                onFocus={onFocus}
                value={value}
                fluid
                placeholder='Search...'
              />
            )}
          />
        </Grid.Column>

        <Grid.Column computer={4} tablet={5} largeScreen={3} mobile={16}>
          <Controller
            name="engines"
            control={control}
            rules={{
              validate: value => value && value.length >= 1
            }}
            render={({ onChange, onBlur, value, name, ref }) => (
              <Dropdown
                placeholder='Engines'
                error={!!errors[name]}
                name={name}
                ref={ref}
                value={value}
                onChange={(e, { value }) => onChange(value)}
                onFocus={onBlur}
                fluid
                multiple
                selection
                options={options}
              />
            )}
          />
        </Grid.Column>

        <Grid.Column computer={3} tablet={5} largeScreen={3} mobile={16}>
          <Button primary>Search</Button>
        </Grid.Column>
      </Grid>
    </form>
  )
}

SearchForm.propTypes = {
  onSubmit: propTypes.func,
  values: propTypes.object
}

export default SearchForm;
