import {useHistory, useLocation} from "react-router-dom";
import qs from 'query-string';

export default function useSearchParams() {
  const location = useLocation();

  const query = {
    offset: 0,
    engines: [],
    term: '',
    ...qs.parse(location.search, { arrayFormat: 'bracket' })
  };

  return {
    ...query,
    offset: parseInt(query.offset, 10),
  }
};
