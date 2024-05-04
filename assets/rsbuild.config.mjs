import { defineConfig } from '@rsbuild/core';
import { pluginReact } from '@rsbuild/plugin-react';

const path = require("path")

export default defineConfig({
  source: {
    entry: {
      app: './js/app.js',
    },
  },
  output: {
    // By default, build is done to dist/assets/<js, css, font>/...
    distPath: {
      root: path.join(__dirname, "../priv/static"),
      js: "assets",
      css: "assets",
      font: "fonts"
      // js: "js",
      // css: "css",
      // font: "fonts"
    },
    cleanDistPath: true,
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
