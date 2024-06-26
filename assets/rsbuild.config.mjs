import { defineConfig } from "@rsbuild/core";
import { pluginReact } from "@rsbuild/plugin-react";

const path = require("path")

export default defineConfig(({_env, _command}) => {
  return {
    source: {
      entry: {
        app: "./js/app.js",
      },
    },
    output: {
      // Do not hash name in dev
      // filename: {
      //   js: "[name].js",
      //   css: "[name].css",
      // },
      filenameHash: false,
      // By default, build is done to dist/assets/<js, css, font>/...
      distPath: {
        root: path.join(__dirname, "../priv/static"),
        js: "assets",
        css: "assets",
        font: "fonts",
        image: "images",
      },
      // Replace rim-raf
      cleanDistPath: true,
      // Default charset is ascii
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
  }
})
