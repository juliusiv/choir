import React from "react";
import Link from "<choir>/components/Link";

class Frontpage extends React.Component {
    render() {
        return (
            <div>
                <h1>Choir</h1>

                <div>
                    <p>It's good that you're here — we can always use another musician.</p>

                    <p>If you already have an account, <Link to="/listen">click here</Link> to listen. If you don't have an account, <Link to="/signup">click here</Link> to sign up. If you're confused about what this is, <Link to="/about">click here</Link> to find out.</p>
                </div>
            </div>
        );
    }
}

export default Frontpage;