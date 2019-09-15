import React from "react";
import PageContainer, { Pages } from "<choir>/containers/PageContainer";


class Rehearse extends React.Component {
    render() {
        return (
            <PageContainer withNavigation={true} page={Pages.REHEARSE}>
                rehearse here
            </PageContainer>
        );
    }
}

export default Rehearse;