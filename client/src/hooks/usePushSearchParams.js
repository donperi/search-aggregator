import { useHistory } from "react-router-dom";
import qs from 'query-string';

export default function useSearchParams() {
  const { push } = useHistory();

  return (searchParams) => {
    push({
      search: qs.stringify(searchParams, { arrayFormat: 'bracket' })
    })
  }
};
