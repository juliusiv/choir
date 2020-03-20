import { useEffect, useRef } from "react";

const useInterval = (callback, delay) => {
  const savedCallback = useRef();

  // Remember the latest callback.
  useEffect(() => {
    savedCallback.current = callback;
  }, [callback]);

  // Set up the interval.
  useEffect(() => {
    let tick = () => savedCallback.current();
    if (delay !== null) {
      let id = setInterval(tick, delay);
      console.log("cleaning up")
      return () => clearInterval(id);
    }
  }, [delay]);
};

export default useInterval;
