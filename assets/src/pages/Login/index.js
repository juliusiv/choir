import React, { useState } from "react";
import useForm from "react-hook-form";
import { Redirect } from "react-router-dom";
import { isEmpty } from "lodash";

import css from "<style>";
import PageContainer, { Pages } from "<choir>/containers/PageContainer";
import Button from "<choir>/components/Button";
import { TextField } from "<choir>/components/FormFields";

const Login = ({ ...props }) => {
    const [requestError, setRequestError] = useState(undefined);
    const [redirectTo, setRedirectTo] = useState(undefined);

    const { register, handleSubmit, errors: formErrors } = useForm();
    const onSubmit = (data) => {
        if (!isEmpty(formErrors)) return;

        fetch("/api/log_in", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
            .then(res => {
                switch (res.status) {
                    case 200:
                        setRedirectTo("/listen");
                        break;
                    case 400:
                    case 404:
                        setRequestError("That email and password combination wasn't found.");
                        break;
                    default:
                        setRequestError("There was an unknown problem. Please try again later.");
                }
            });
    };

    if (redirectTo !== undefined) return <Redirect to={redirectTo} />;

    return (
        <PageContainer withNavigation={false} page={Pages.LOGIN}>
            <h1>Log in to Choir</h1>

            <form onSubmit={handleSubmit(onSubmit)} className={css`mt2`}>
                <TextField
                    name="email"
                    placeholder="Email"
                    className={css`mb1`}
                    error={!!formErrors && formErrors.email}
                    ref={register({ required: "This field is required" })}
                />

                <TextField
                    name="password"
                    type="password"
                    placeholder="Password"
                    className={css`mb2`}
                    error={!!formErrors && formErrors.password}
                    ref={register({ required: "This field is required" })}
                />

                {!!requestError && (
                    <div className={css`bgRed mb1 p2 border bcBlack`}>
                        {requestError}
                    </div>
                )}

                <Button type="submit" className={css`block`}>
                    Log in
                </Button>
            </form>
        </PageContainer>
    );
};

export default Login;