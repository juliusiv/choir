import React from "react";
import classnames from "classnames";

import css from "<style>";

const Button = ({ children, className, ...props }) => {
    return (
        <button
            className={classnames(
                css`bgDarkGreen pb1 pt1 pl2 pr2 bold serif fontNormal mr2 cursorPointer`,
                className,
                {
                    [css`bgLightGreen cursorDefault`]: props.disabled,
                })}
            {...props}
        >
            {children}
        </button>
    );
};

export default Button;