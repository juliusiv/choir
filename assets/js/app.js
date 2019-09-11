import React from "react";

// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import ReactDOM from "react-dom";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

import { About, Frontpage, Listen, Rehearse } from "./pages";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

class App extends React.Component {
    render() {
        return (
            <Router>
                <div className="bg-ivory height-all serif overflow-auto">
                    <div className="p2">
                        <Route path="/" exact component={Frontpage} />
                        <Route path="/rehearse" exact component={Rehearse} />
                        <Route path="/listen" exact component={Listen} />
                        <Route path="/about" exact component={About} />
                    </div>
                </div>
            </Router>
        );
    }
}

ReactDOM.render(<App />, document.getElementById("root"));