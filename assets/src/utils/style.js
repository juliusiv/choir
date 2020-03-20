// Not sure why this needs to be a relative import instead of <choir>/App.css, but it does...
import styles from "../App.css";

/*
  OK, so what is this? Well, I _wanted_ atomic CSS classes and CSS modules, but Webpack was
  being a PITA and I couldn't quite get both working together, and even when I felt like I was
  getting close everything was basically just getting special-cased. Instead, this is what I've
  come up with. This is a tagged template literal function. It essentially parses a template
  string. It's meant to be used for CSS classes:

    css`bgRed p1 heightAll` === "bgRed_akhsjkdhasjd p1_wierpweior heightAll_xcnvxmnv"

  What's happening is the tagged template literal function is turning our normal, human-readable
  atomic CSS names into the hashed up versions. I'm actually pretty into this because it means
  we have one way of dealing with CSS (it's all CSS modules) _and_ we get something very much like
  atomic CSS.

  Note: This file is Webpack aliased to <style> so it can be used more easily.
*/
const css = ([cssClasses, raw]) => {
  return cssClasses.split(" ").map(cssClass => {
    const computedClass = styles[cssClass];
    if (computedClass === undefined) {
      console.warn(`The class "${cssClass}" doesn't exist in the atomic CSS definitions, App.css`);
    }

    return computedClass
  }).join(" ");
}

export default css;
