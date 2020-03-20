import React, { forwardRef } from "react";
import classnames from "classnames";

import css from "<style>";
import style from "./FormFields.module.css";

// We need this forwardRef thing because of the way function components handle refs.
// See https://github.com/atomiks/tippy.js-react/issues/49. We specifically use it here
// because we typically use refs on form fields in order to manage these components from the
// top-level form.
const TextField = forwardRef(({ className, error, type, ...props }, ref) => {
  return (
    <div className={className}>
      <input
        type={type}
        className={classnames({
          [style.textField]: true,
          [css`fontNormal serif block`]: true,
          [css`border bcRed`]: !!error,
        })}
        ref={ref}
        {...props}
      />
      {!!error && <span className={css`cRed mt1`}>{error.message}</span>}
    </div>
  );
});

TextField.defaultProps = {
  type: "text"
}

export default TextField;
