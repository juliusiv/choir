import React from "react";
import PageContainer, { Pages } from "<choir>/containers/PageContainer";


class Rehearse extends React.Component {
    render() {
        return (
            <PageContainer withNavigation={true} page={Pages.REHEARSE}>
                <h1>Rehearse</h1>

                <div>
                    In the rehearsal space you can play around with different values to see what happens.
                </div>

            </PageContainer>
        );
    }
}

export default Rehearse;