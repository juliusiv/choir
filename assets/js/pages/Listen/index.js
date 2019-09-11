import React from "react";
import NavigationContainer from "<choir>/containers/NavigationContainer";
import { useSynthesizer } from "<choir>/utils/synthesizer";
import Button from "<choir>/components/Button";

const Listen = props => {
    const synthesizer = useSynthesizer();

    return (
        <NavigationContainer>
            <div>listen</div>
            <Button onClick={synthesizer.unmute}>start</Button>
            <Button onClick={synthesizer.mute}>stop</Button>

            <Button onClick={() => synthesizer.setFrequency(261.63)}>C</Button>
            <Button onClick={() => synthesizer.setFrequency(293.66)}>D</Button>
            <Button onClick={() => synthesizer.setFrequency(329.63)}>E</Button>
            <Button onClick={() => synthesizer.setFrequency(349.23)}>F</Button>
            <Button onClick={() => synthesizer.setFrequency(392.00)}>G</Button>
            <Button onClick={() => synthesizer.setFrequency(440.00)}>A</Button>
            <Button onClick={() => synthesizer.setFrequency(493.88)}>B</Button>
            <Button onClick={() => synthesizer.setFrequency(523.25)}>C</Button>
        </NavigationContainer>
    );
}

export default Listen;