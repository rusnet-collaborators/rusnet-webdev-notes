config = (require './config.coffee')()
gulp   = require 'gulp'
path   = require 'path'

gulp.task 'copy_css', ->
  gulp.src path.join config.dev_path_static, '*.css'
    .pipe gulp.dest config.prod_path_static

gulp.task 'copy_images', ->
  gulp.src path.join config.dev_path_static, '*.png'
    .pipe gulp.dest config.prod_path_static

gulp.task 'copy_static', ['copy_css', 'copy_images']
