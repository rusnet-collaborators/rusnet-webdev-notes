config = (require './config.coffee')()
gulp   = require 'gulp'
path   = require 'path'

gulp.task 'copy', ->
  gulp.src path.join config.dev_path_css, '*.css'
    .pipe gulp.dest config.prod_path_css
  gulp.src path.join config.dev_path_img, '*.png'
    .pipe gulp.dest config.prod_path_img
  gulp.src path.join config.dev_path_img, '*.jpg'
    .pipe gulp.dest config.prod_path_img
  gulp.src path.join config.dev_path_js, '*.js'
    .pipe gulp.dest config.prod_path_js
  return

gulp.task 'copy_static', ['copy']
