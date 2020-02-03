import React from "react";
import classnames from "classnames";

import css from "<style>";

const Button = ({ children, className, disabled, ...props }) => {
    const style = disabled ? {
        background: "linear-gradient(to left top, transparent 47.75%, currentColor 49.5%, currentColor 50.5%, transparent 52.25%)"
    } : {};

    return (
        <button
            className={classnames(
                css`border bcBlack bgWhite pb1 pt1 pl2 pr2 bold serif fontNormal mr2 cursorPointer`,
                className,
                {
                    [css`bgLightGreen cursorDefault`]: disabled,
                })}
            style={style}
            {...props}
        >
            {children}
        </button>
    );
};

export default Button;
