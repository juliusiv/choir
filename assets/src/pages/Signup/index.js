import React, { useState } from "react";
import useForm from "react-hook-form";
import { Redirect } from "react-router-dom";
import { isEmpty } from "lodash";

import css from "<style>";
import PageContainer, { Pages } from "<choir>/containers/PageContainer";
import Button from "<choir>/components/Button";
import { TextField } from "<choir>/components/FormFields";

const Signup = ({ ...props }) => {
    const [requestError, setRequestError] = useState(undefined);
    const [redirectTo, setRedirectTo] = useState(undefined);

    const { register, handleSubmit, errors: formErrors } = useForm();
    const onSubmit = (data) => {
        if (!isEmpty(formErrors)) return;

        fetch("/api/sign_up", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
            .then(res => {
                switch (res.status) {
                    case 200:
                        setRedirectTo("/listen?new-signup");
                        break;
                    case 409:
                        setRequestError("A user with that email already exists.");
                        break;
                    default:
                        setRequestError("There was an unknown problem. Please try again later.");
                }
            });;
    };

    if (redirectTo !== undefined) return <Redirect to={redirectTo} />;

    return (
        <PageContainer withNavigation={false} page={Pages.SIGNUP}>
            <h1>Sign up for Choir</h1>

            <form onSubmit={handleSubmit(onSubmit)} className={css`mt2`}>
                <TextField
                    name="first_name"
                    placeholder="First Name"
                    className={css`block mb1`}
                    error={!!formErrors && formErrors.first_name}
                    ref={register({ required: "This field is required" })}
                />

                <TextField
                    name="last_name"
                    placeholder="Last Name"
                    className={css`block mb1`}
                    error={!!formErrors && formErrors.last_name}
                    ref={register({ required: "This field is required" })}
                />

                <TextField
                    name="email"
                    placeholder="Email"
                    className={css`block mb1`}
                    error={!!formErrors && formErrors.email}
                    ref={register({ required: "This field is required" })}
                />

                <TextField
                    name="password"
                    type="password"
                    placeholder="Password"
                    className={css`block mb2`}
                    error={!!formErrors && formErrors.password}
                    ref={register({ required: "This field is required" })}
                />

                {!!requestError && (
                    <div className={css`bgRed mb1 p2 border bcBlack`}>
                        {requestError}
                    </div>
                )}

                <Button type="submit" className={css`block`}>
                    Sign up
                </Button>
            </form>
        </PageContainer>
    );
};

export default Signup;