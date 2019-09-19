import { useState, useEffect } from "react";
import { forOwn } from "lodash";

const useChannel = (socket, topic, onJoin, dataHandlers) => {
    // The socket should already be connected or else we'll have problems joining the channel.
    const [channel, setChannel] = useState(socket.channel(topic, {}));

    useEffect(() => {
        channel.join()
            .receive("ok", onJoin)
            .receive("error", resp => console.log(`Unable to join topic ${topic}`, resp));
        // We need to register the callbacks in the useEffect so they only get run once.
        forOwn(dataHandlers, (callback, event) => {
            console.log(`Registering handler for event "${event}"`);
            channel.on(event, callback);
        });
        return () => {
            if (channel) channel.leave();
        }
    }, [])

    return channel;
}

export default useChannel;
