import React from "react";
import PropTypes from "prop-types";

const LoadingSpinner = props => (
  <svg
    version="1.1"
    width={props.width}
    height={props.height}
    xmlns="http://www.w3.org/2000/svg"
    x="0px"
    y="0px"
    aria-label={props.label}
  >
    <circle
      fill="none"
      stroke={props.color}
      strokeWidth="4"
      cx="50"
      cy="50"
      r="44"
      style={{ opacity: 0.5 }}
    />
    <circle fill={props.color} stroke={props.color} strokeWidth="3" cx="8" cy="54" r="6">
      <animateTransform
        attributeName="transform"
        dur="2s"
        type="rotate"
        from="0 50 48"
        to="360 50 52"
        repeatCount="indefinite"
      />
    </circle>
  </svg>
);

LoadingSpinner.propTypes = {
  height: PropTypes.string,
  width: PropTypes.string,
  color: PropTypes.string,
  label: PropTypes.string
};

LoadingSpinner.defaultProps = {
  height: "100%",
  width: "100%",
  color: "green",
  label: "audio-loading"
};

export default LoadingSpinner;
