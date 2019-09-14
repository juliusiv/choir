import React from "react";
import Navigation from "<choir>/components/Navigation";

const NavigationContainer = ({ active, children, ...props }) => {
    return (
        <div className="flex">
            <Navigation />
            <div className="ml3">
                {children}
            </div>
        </div>
    );
};

export default NavigationContainer;