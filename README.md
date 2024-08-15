# PhxRsbuild

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Description

Testing Rsbuild pipeline with Phoenix 1.7

Rsbuild is a bundler written in Rust aiming at replacing webpack

https://rsbuild.dev

## Create project

```
mix phx.new --no-assets --binary-id phx_rsbuild
cd phx_rsbuild
mix ecto.create

mkdir assets
cd assets
npm init -y
```
* Deps

Deps et scripts

```
  "scripts": {
    "watch": "rsbuild build --watch",
    "deploy": "rsbuild build",
    "dev": "rsbuild dev --open",
    "build": "rsbuild build",
    "preview": "rsbuild preview"
  },
  "dependencies": {
    "@popperjs/core": "^2.11.8",
    "bootstrap": "^5.3.3",
    "bootstrap-icons": "^1.11.3",
    "phoenix": "file:../deps/phoenix",
    "phoenix_html": "file:../deps/phoenix_html",
    "phoenix_live_view": "file:../deps/phoenix_live_view",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "topbar": "^2.0.2"
  },
  "devDependencies": {
    "@rsbuild/core": "^0.6.9",
    "@rsbuild/plugin-react": "^0.6.9"
  }
```

* Git

```
git init 
vim .gitignore
# Local
.DS_Store
*.local
*.log*

# Dist
/assets/node_modules
/priv/static

# IDE
.vscode/*
!.vscode/extensions.json
.idea

git add .
git commit -m "Initial commit"
```

## Mise à jour des outils

* Update rsbuild to 1.0.1-beta-3

* Update rsbuild config

Silence errors waiting for next BS version to solve this...

```
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
```

* Fix bootstrap icons and rsbuild by adding an option...

```
$bootstrap-icons-font-dir: "~bootstrap-icons/font/fonts";
@import "~bootstrap-icons/font/bootstrap-icons.scss";
```
