p = require 'path'


root = p.resolve '.', '..'

database_path    = p.join root, 'database' 

dev_path         = p.join root, 'dev'
dev_path_static  = p.join dev_path, 'static'
                
prod_path        = p.join root, 'prod'
prod_path_static = p.join prod_path, 'static'


module.exports = ->
  root : root

  database_path    : database_path

  dev_path         : dev_path
  dev_path_static  : dev_path_static
                
  prod_path        : prod_path
  prod_path_static : prod_path_static
