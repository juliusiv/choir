import React from "react";

import css from "<style>";
import { Link as ReactRouterLink } from "react-router-dom";

const Link = props => {
    return <ReactRouterLink className={css`cDarkGreen`} {...props} />
}

export default Link;