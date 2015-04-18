$      = (require 'gulp-load-plugins')()
config = (require './config.coffee')()
gulp   = require 'gulp'
path   = require 'path'

gulp.task 'predeploy', ->
  gulp.src path.join config.dev_path, 'CNAME'
    .pipe gulp.dest config.prod_path_static

gulp.task 'deploy', ['predeploy'], $.shell.task [ 'surge ' + config.prod_path_static ]
