import queryString from "query-string";
import qs from "query-string";

export function apiUrl(path,  params) {
  const query = queryString.stringify(params, { arrayFormat: 'bracket' });

  return `${process.env.REACT_APP_SEARCH_API}/search?${query}`
}

export function pushSearchParams(params) {
  return qs.stringify(params, { arrayFormat: 'bracket' });
}
