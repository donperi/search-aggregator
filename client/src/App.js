import 'semantic-ui-css/semantic.min.css'
import './css/utils.css';
import './App.css';

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Redirect
} from "react-router-dom";

import Search from './pages/Search/Search';

function App() {
  return (
    <>
      <Router>
        <Switch>
          <Route exact path="/search">
            <Search />
          </Route>
          <Route exact path="*">
            <Redirect to='/search' />
          </Route>
        </Switch>
      </Router>
    </>
  );
}

export default App;
