import React from "react";

import Link from "<choir>/components/Link";

const NavLink = ({ children, ...props }) => {
    return (
        <div>
            <Link {...props}>{children}</Link>
        </div>
    );
};

const Navigation = props => {
    return (
        <nav className="bg-crimson bold block" {...props}>
            <NavLink to="/listen">Listen</NavLink>
            <NavLink to="/account">Account</NavLink>
        </nav>
    );
};

export default Navigation;