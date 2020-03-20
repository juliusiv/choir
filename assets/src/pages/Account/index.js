import React, { useState, useEffect } from "react";
import { Redirect } from "react-router-dom";
import moment from "moment";

import PageContainer, { Pages } from "<choir>/containers/PageContainer";
import Button from "<choir>/components/Button";
import css from "<style>";
import LoadingSpinner from "<choir>/components/LoadingSpinner";

const Frontpage = ({ ...props }) => {
  const [requestError, setRequestError] = useState(undefined);
  const [redirectTo, setRedirectTo] = useState(undefined);
  const handleLogOut = () => {
    fetch("/api/log_out", {
      method: "DELETE",
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

  const [isLoading, setIsLoading] = useState(true);
  const [accountInfo, setAccountInfo] = useState(undefined);
  useEffect(() => {
    fetch("/api/users", {
      method: "GET",
      headers: {
        "Content-Type": "application/json"
      },
    })
      .then(res => {
        switch (res.status) {
          case 200:
            res.json().then(info => {
              setAccountInfo(info);
              setIsLoading(false);
            })
            break;
          default:
            setRequestError("There was a problem fetching your user information.");
            setIsLoading(false);
        }
      });
  }, [1]);

  if (redirectTo !== undefined) return <Redirect to={redirectTo} />;

  return (
    <PageContainer page={Pages.ACCOUNT} withNavigation={true}>
      {/* <h1>Account</h1> */}

      {isLoading ? <LoadingSpinner color="black" /> : (
        <div className={css`mb3`}>
          <h1>{`${accountInfo.first_name} ${accountInfo.last_name}`}</h1>
          <p>Member since {moment(accountInfo.created_at).format("D MMMM, YYYY")}</p>
          {/* <p>{JSON.stringify(accountInfo)}</p> */}
        </div>
      )}

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
