import { defineConfig } from "@rsbuild/core";
import { pluginReact } from "@rsbuild/plugin-react";
import { pluginSass } from "@rsbuild/plugin-sass"

const path = require("path")

const isDev = process.env.NODE_ENV === "development";

export default defineConfig(({env, command}) => {
  console.log("rsbuild CMD: ", command, " ENV: ", env, " ISDEV: ", isDev)
  return {
    source: {
      entry: {
        app: "./js/app.js",
      },
    },
    // Do not generate html... because we use phoenix template
    tools: {
      htmlPlugin: false, // Disables the HTML plugin
    },
    html: false,
    output: {
      // Do not hash name in dev
      filename: {
        js: "[name].js",
        css: "[name].css",
      },

      // By default, build is done to dist/assets/<js, css, font>/...
      distPath: {
        root: path.join(__dirname, "../priv/static"),
        js: "js",
        css: "css",
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
      externals: {
        jwplayer: "jwplayer"
      },
    },
    plugins: [
      pluginReact(),
      pluginSass(
        // Depreciation warnings between bootstrap 5.3 and sass
        // https://github.com/twbs/bootstrap/issues/40621
        // Remove when bootstrap fix issues with sass!
        {
          sassLoaderOptions: {
            sassOptions: {
              silenceDeprecations: ["mixed-decls"]
            },
          }}
      ),
    ],
  }
})
