import React from "react";

// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "./App.css";
import css from "<style>";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import ReactDOM from "react-dom";
import classNames from "classnames";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

import { About, Account, Frontpage, Listen, Login, Rehearse, Signup } from "./pages";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

class App extends React.Component {
  render() {
    return (
      <Router>
        <div className={css`bgWhite heightAll serif overflowAuto`}>
          <Route path="/" exact component={Frontpage} />
          <Route path="/rehearse" exact component={Rehearse} />
          <Route path="/listen" exact component={Listen} />
          <Route path="/about" exact component={About} />
          <Route path="/account" exact component={Account} />
          <Route path="/login" exact component={Login} />
          <Route path="/signup" exact component={Signup} />
        </div>
      </Router>
    );
  }
}

ReactDOM.render(<App />, document.getElementById("root"));
