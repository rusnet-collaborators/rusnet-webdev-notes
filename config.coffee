path = require 'path'

root = __dirname

database_path    = path.join root, 'database'

dev_path         = path.join root, 'dev'
dev_path_static  = path.join dev_path, 'static'
dev_path_js      = path.join dev_path_static, 'js'
dev_path_coffee  = path.join dev_path_static, 'coffee'
dev_path_css     = path.join dev_path_static, 'css'
dev_path_sass    = path.join dev_path_static, 'sass'
dev_path_img     = path.join dev_path_static, 'img'

prod_path        = path.join root, 'prod'
prod_path_static = path.join prod_path, 'static'
prod_path_js     = path.join prod_path_static, 'js'
prod_path_coffee = path.join prod_path_static, 'coffee'
prod_path_css    = path.join prod_path_static, 'css'
prod_path_sass   = path.join prod_path_static, 'sass'
prod_path_img    = path.join prod_path_static, 'img'

module.exports =
  root:             root

  database_path:    database_path

  dev_path:         dev_path
  dev_path_static:  dev_path_static
  dev_path_js:      dev_path_js
  dev_path_coffee:  dev_path_coffee
  dev_path_css:     dev_path_css
  dev_path_sass:    dev_path_sass
  dev_path_img:     dev_path_img

  prod_path:        prod_path
  prod_path_static: prod_path_static
  prod_path_js:     prod_path_js
  prod_path_coffee: prod_path_coffee
  prod_path_css:    prod_path_css
  prod_path_sass:   prod_path_sass
  prod_path_img:    prod_path_img
