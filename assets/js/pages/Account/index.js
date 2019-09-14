import React from "react";
import PageContainer, { Pages } from "<choir>/containers/PageContainer";

class Frontpage extends React.Component {
    render() {
        return (
            <PageContainer page={Pages.ACCOUNT} withNavigation={true}>
                <h1>Account</h1>

                <div>
                    <p>Name and such</p>
                </div>
            </PageContainer>
        );
    }
}

export default Frontpage;