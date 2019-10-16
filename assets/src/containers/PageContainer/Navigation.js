import React from "react";
import classNames from "classnames";

import Icon from "<choir>/components/Icon";
import Link from "<choir>/components/Link";
import css from "<style>";
import Pages from "./Pages";

const NavLink = ({ children, isActive, ...props }) => {
    const classes = classNames(
        css`pl2 pr2 pt1 pb1 cWhite block underlineNone`,
        { [css`bgDarkGreen bold`]: isActive }
    );

    return (
        <Link {...props} className={classes}>
            {children}
        </Link>
    );
};

const PAGE_LINKS = [
    {
        title: "Listen",
        to: "/listen",
        page: Pages.LISTEN,
    },
    {
        title: "Rehearse",
        to: "/rehearse",
        page: Pages.REHEARSE,
    },
    {
        title: "Account",
        to: "/account",
        page: Pages.ACCOUNT,
    },
];

const Navigation = ({ active, ...props }) => {
    return (
        <nav className={css`bgBlack cWhite`} {...props}>
            <Link to="/" className={css`pl2 pr2 pb3 pt3 bgRed cWhite bold block fontMedium cursorPointer underlineNone flex justifyCenter`}>
                <div style={{ height: "2rem" }}>
                    <Icon icon="logo" color="var(--chr-white)" className={css`heightAll`} />
                </div>
            </Link>
            {
                PAGE_LINKS.map(({ to, page, title }) => (
                    <NavLink to={to} isActive={page === active} key={page}>
                        {title}
                    </NavLink>
                ))
            }
        </nav>
    );
};

export default Navigation;
