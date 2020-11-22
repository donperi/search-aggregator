import { apiUrl } from "../helpers";

async function searchTerm (key, term, engines, offset = 0) {
  const response = await fetch(apiUrl('/search', {
    term, engines, offset
  }));

  if (response.status >= 400) {
    throw new Error('request error');
  }

  return response.json();
}

export default searchTerm;
