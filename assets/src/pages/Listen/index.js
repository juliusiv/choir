import React, { useState } from "react";
import useMousePosition from "@react-hook/mouse-position";

import css from "<style>";
import PageContainer, { Pages } from "<choir>/containers/PageContainer";
import { useSynthesizer } from "<choir>/utils/synthesizer";
import { useChannel, useSocket } from "<choir>/utils/sockets";
import useInterval from "<choir>/utils/useInterval";
import Button from "<choir>/components/Button";

const Listen = (props) => {
    const synthesizer = useSynthesizer();
    const [choirData, setChoirData] = useState(0);
    const socket = useSocket();

    const channel = useChannel(
        socket,
        "listen:ambient",
        () => console.log("joined!"),
        {
            "listen:data": newChoirData => {
                setChoirData(newChoirData.count);
            }
        }
    );

    const [mousePositionRef, mousePosition] = useMousePosition(0, 0, 20);

    useInterval(() => {
        console.log("nice")
        channel.push("listen:data", {
            mouseX: mousePosition.x,
            mouseY: mousePosition.Y
        });
    }, 1000);

    return (
        <PageContainer withNavigation={true} page={Pages.LISTEN}>
            <h1>Listen</h1>

            <div onClick={synthesizer.start} className={css`p3 cursorPointer textCenter bgRed cWhite mb3 italic`}>
                Click here to start the symphony {}
                <span title="Some browsers don't like it when sounds automatically start playing without your consent." className={css`fontTiny cursorHelp bold`}>
                    &#9432;
                </span>
            </div>
            <div className={css`mb3`}>
                connections: {JSON.stringify(choirData)}
                {/* mouseX: {choirData.mouseX}
                mouseY: {choirData.mouseY}
                connections: {choirData.connections} */}
            </div>
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
        </PageContainer>
    );
}

export default Listen;
