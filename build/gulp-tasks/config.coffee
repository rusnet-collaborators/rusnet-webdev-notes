path = require 'path'

root = path.resolve '.', '..'

database_path    = path.join root, 'database'

dev_path         = path.join root, 'dev'
dev_path_static  = path.join dev_path, 'static'

prod_path        = path.join root, 'prod'
prod_path_static = path.join prod_path, 'static'

module.exports = ->
  root:             root

  database_path:    database_path

  dev_path:         dev_path
  dev_path_static:  dev_path_static

  prod_path:        prod_path
  prod_path_static: prod_path_static
