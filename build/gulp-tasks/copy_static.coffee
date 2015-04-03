config = (require './config.coffee')()
gulp   = require 'gulp'
path   = require 'path'

gulp.task 'copy', ->
  gulp.src path.join config.dev_path_static, '*.css'
    .pipe gulp.dest config.prod_path_static
  gulp.src path.join config.dev_path_static, '*.png'
    .pipe gulp.dest config.prod_path_static
  gulp.src path.join config.dev_path_static, '*.jpg'
    .pipe gulp.dest config.prod_path_static

gulp.task 'copy_static', ['copy']
