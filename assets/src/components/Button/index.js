import React from "react";

import css from "<style>";

const Button = ({ children, ...props }) => {
    return (
        <button className={css`bgDarkGreen pb1 pt1 pl2 pr2 bold serif fontNormal mr2`} {...props}>
            {children}
        </button>
    );
};

export default Button;