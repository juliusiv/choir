import React from "react";

import { Link as ReactRouterLink } from "react-router-dom";

const Link = props => {
    return <ReactRouterLink className="c-crimson bold" {...props} />
}

export default Link;