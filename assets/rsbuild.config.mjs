import { defineConfig } from "@rsbuild/core";
import { pluginReact } from "@rsbuild/plugin-react";

const path = require("path")

export default defineConfig({
  source: {
    entry: {
      app: "./js/app.js",
    },
  },
  output: {
    // Do not hash name in dev
    filename: {
      js: "[name].js",
      css: "[name].css",
    },
    // By default, build is done to dist/assets/<js, css, font>/...
    distPath: {
      root: path.join(__dirname, "../priv/static"),
      js: "assets",
      css: "assets",
      font: "fonts",
      image: "images",
    },
    cleanDistPath: true,
    charset: "utf8",
    // Replace copy-webpack-plugin
    copy: [{
      from: "./static", 
      to: path.join(__dirname, "../priv/static")
    }],
    // externals: {
    //   jwplayer: "jwplayer"
    // },
  },
  plugins: [
    pluginReact()
  ],
});
