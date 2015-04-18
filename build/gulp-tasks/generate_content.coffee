$        = (require 'gulp-load-plugins')()
config   = (require './config.coffee')()
gulp     = require 'gulp'
gulpsync = $.sync gulp
path     = require 'path'
del      = require 'del'

gulp.task 'gen_js', ->
  gulp.src path.join config.dev_path_coffee, '*.coffee'
    .pipe $.coffee({bare: true}).on 'error', $.util.log
    .pipe gulp.dest path.join config.prod_path_js

gulp.task 'gen_markdown', ->
  gulp.src path.join config.database_path, '*.md'
    .pipe $.markdown()
    .pipe gulp.dest config.dev_path_static

gulp.task 'gen_html', (cb) ->
  gulp.src path.join config.dev_path_static, '*.html'
    .pipe $.htmlincluder()
    .pipe gulp.dest config.prod_path_static
  cb()

gulp.task 'generate_content', gulpsync.sync [
  'gen_js'
  'gen_markdown'
  'gen_html'
]
