import React from "react";
import classNames from "classnames";

import Icon from "<choir>/components/Icon";
import Link from "<choir>/components/Link";
import css from "<style>";
import Pages from "./Pages";

const NavLink = ({ children, isActive, ...props }) => {
  const classes = classNames(
    css`pl2 pr2 pt1 pb1 mr3 ml3 cBlack block underlineNone`,
    { [css`borderBottom bold borderTop bcBlack`]: isActive }
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
    <div>
      <Link to="/" className={css`pb3 pt3 cBlack bold block fontMedium cursorPointer underlineNone flex justifyCenter`}>
        <div style={{ height: "2rem" }}>
          {/* Choir */}
          <Icon icon="logo" color="var(--chr-black)" className={css`heightAll`} />
        </div>
      </Link>
      <nav className={css`flex flexRow justifyCenter borderBottom bcBlack pt1 pb1`} {...props}>
        {
          PAGE_LINKS.map(({ to, page, title }) => (
            <NavLink to={to} isActive={page === active} key={page}>
              {title}
            </NavLink>
          ))
        }
      </nav>
    </div>
  );
};

export default Navigation;
