import React from "react";
import Navigation from "./Navigation";
import css from "<style>";


const PageContainer = ({ page, children, withNavigation, ...props }) => {
    const leftRightPadding = "20%";
    return (
        <div className={css`heightAll`} style={{ paddingLeft: leftRightPadding, paddingRight: leftRightPadding }} {...props}>
            {
                withNavigation && <Navigation active={page} />
            }
            <div className={css`pb3 pt3`}>
                {children}
            </div>
        </div>
    );
};

export default PageContainer;
