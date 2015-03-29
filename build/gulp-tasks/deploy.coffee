$ = (require 'gulp-load-plugins')()

gulp = require 'gulp'

config = (require './config.coffee')()

p = require 'path'


gulp.task 'predeploy', ->
  gulp.src p.join config.dev_path,'CNAME'
    .pipe gulp.dest config.prod_path_static

gulp.task 'deploy', ['predeploy'], $.shell.task [ 'surge ' + config.prod_path_static ]
