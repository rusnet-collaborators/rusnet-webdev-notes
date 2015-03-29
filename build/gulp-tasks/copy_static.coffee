$ = (require 'gulp-load-plugins')()

gulp = require 'gulp'

config = (require './config.coffee')()

p = require 'path'


gulp.task 'copy_css', ->
  gulp.src p.join config.dev_path_static, '*.css'
    .pipe gulp.dest config.prod_path_static

gulp.task 'copy_images', ->
  gulp.src p.join config.dev_path_static, '*.png'
    .pipe gulp.dest config.prod_path_static

gulp.task 'copy_static', ['copy_css', 'copy_images']
