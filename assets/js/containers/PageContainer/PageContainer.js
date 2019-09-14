import React from "react";
import Navigation from "./Navigation";
import css from "<style>";


const PageContainer = ({ page, children, withNavigation, ...props }) => {
    return (
        <div className={css`heightAll flex`} {...props}>
            {
                withNavigation && <Navigation active={page} />
            }
            <div className={css`ml3 pr2 pl2 pt3`}>
                {children}
            </div>
        </div>
    );
};

export default PageContainer;