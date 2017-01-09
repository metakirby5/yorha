path = require 'path'
webpack = require 'webpack'
merge = require 'webpack-merge'
HtmlWebpackPlugin = require 'html-webpack-plugin'

# Paths
dir = (name) -> path.join __dirname, name
SRC_PATH = dir 'src'
BUILD_PATH = dir 'dist'

# The main config
module.exports =
  # What file to start at
  entry: [path.join SRC_PATH, 'index.js']

  # Where to output
  output:
    path: BUILD_PATH
    publicPath: '/'
    filename: '[name].js'

  # Where to load modules from
  resolve:
    root: SRC_PATH
    modulesDirectories: ['node_modules']
    extensions: ['', '.styl', '.js']

  # Stylus options
  stylus:
    use: [(require 'nib')()]

  # Stylint options
  stylint:
    config: 'stylint.json'

  # Module loading options
  module:
    # Linters, etc.
    preLoaders: [
      # Stylint
      test: /\.styl/
      loaders: ['stylint']
    ]

    # Files to load
    loaders: [
      # Pug
      test: /\.pug$/
      loaders: ['pug-html']
    ,
      # Stylus
      test: /\.styl$/
      loaders: ['style', 'css', 'stylus']
    ]

  plugins: [
    # Generate HTML
    new HtmlWebpackPlugin
      template: path.join SRC_PATH, "index.pug"

    # Hot module replacement
    new webpack.HotModuleReplacementPlugin()
  ]

  devServer:
    # Serve publicly
    host: '0.0.0.0'

    # No iframe
    inline: true

    # Show progress
    progress: true

    # Hot reloading
    hot: true

    # Allow routing
    historyApiFallback: true

    # Display options
    stats:
      # Don't show a bunch of chunk stats
      chunkModules: false

      # Pretty colors
      colors: true
