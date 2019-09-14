import React from "react";

const Button = ({ children, ...props }) => {
    return (
        <button className="bg-gold pb1 pt1 pl2 pr2 bold serif font-normal mr2" {...props}>
            {children}
        </button>
    );
};

export default Button;