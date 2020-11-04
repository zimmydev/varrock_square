const path = require("path");
const glob = require("glob");
const webpack = require("webpack");
const {CleanWebpackPlugin} = require("clean-webpack-plugin");
const HardSourceWebpackPlugin = require("hard-source-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = (env, options) => {
  const DEV_MODE = options.mode !== "production";
  const INLINE_URI_THRESHOLD = 1024 * 4;

  return {
    entry: {
      app: "./js/app",
    },
    output: {
      filename: "js/[name].js",
      path: path.resolve(__dirname, "../priv/static"),
      publicPath: "/",
    },
    optimization: {
      minimizer: [
        new TerserPlugin({cache: true, parallel: true, sourceMap: DEV_MODE}),
        new OptimizeCSSAssetsPlugin({}),
      ],
    },
    devtool: DEV_MODE ? "eval-cheap-module-source-map" : undefined,
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: "babel-loader",
        },
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: {
            loader: "elm-webpack-loader",
            options: {
              cwd: path.resolve(__dirname, "elm"),
            },
          },
        },
        {
          test: /\.s?css$/,
          use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
        },
        {
          test: /\.png$/,
          use: {
            loader: "url-loader",
            options: {
              limit: INLINE_URI_THRESHOLD,
              name: "images/[name].[ext]",
            },
          },
        },
      ],
    },
    plugins: [
      new CleanWebpackPlugin(),
      new MiniCssExtractPlugin({filename: "css/[name].css"}),
      new CopyWebpackPlugin([{from: "static"}]),
    ].concat(
      DEV_MODE
        ? [new HardSourceWebpackPlugin()]
        : [new webpack.ProgressPlugin()]
    ),
  };
};
