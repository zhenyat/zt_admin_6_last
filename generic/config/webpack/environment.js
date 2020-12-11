const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
/***************
 * Makes 'jquery' available in all js-packs through the name '$'
 * It's equivalent to adding at the beginning of each pack:
 *  import $ from 'jquery'
 ***************/
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      Popper: ['popper.js', 'default']
  })
)
module.exports = environment
