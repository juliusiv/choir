const path = require("path");
const glob = require("glob");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const UglifyJsPlugin = require("uglifyjs-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
    "./src/App.js": glob.sync("./vendor/**/*.js").concat(["./src/App.js"])
  },
  output: {
    filename: "App.js",
    path: path.resolve(__dirname, "../priv/static/js")
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      },
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
            options: {
              modules: true,
              localIdentName: '[path][name]__[local]--[hash:base64:5]'
            }
          }
        ]
      }
    ]
  },
  plugins: [
    // This filename is referencing the priv/static App.css, the one in src.
    new MiniCssExtractPlugin({ filename: "../js/App.css" }),
    new CopyWebpackPlugin([{ from: "static/", to: "../" }])
  ],
  resolve: {
    alias: {
      "<choir>": path.resolve(__dirname, "src/"),
      "<style>": path.resolve(__dirname, "src/utils/style.js")
    }
  }
});
