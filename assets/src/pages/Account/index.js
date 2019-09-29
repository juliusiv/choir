import React, { useState } from "react";
import { Redirect } from "react-router-dom";

import PageContainer, { Pages } from "<choir>/containers/PageContainer";
import Button from "<choir>/components/Button";
import css from "<style>";

const Frontpage = ({ ...props }) => {
    const [requestError, setRequestError] = useState(undefined);
    const [redirectTo, setRedirectTo] = useState(undefined);

    const handleLogOut = () => {
        fetch("/api/log_out", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
        })
            .then(res => {
                switch (res.status) {
                    case 200:
                        setRedirectTo("/login");
                        break;
                    default:
                        setRequestError("There was an unknown problem when logging out. Please try again later.");
                }
            });
    };

    if (redirectTo !== undefined) return <Redirect to={redirectTo} />;

    return (
        <PageContainer page={Pages.ACCOUNT} withNavigation={true}>
            <h1>Account</h1>

            <div className={css`mb3`}>
                <p>Name and such</p>
            </div>

            {!!requestError && (
                <div className={css`bgRed mb1 p2 border bcBlack`}>
                    {requestError}
                </div>
            )}

            <Button onClick={handleLogOut}>
                Log out
            </Button>

        </PageContainer>
    );
}

export default Frontpage;