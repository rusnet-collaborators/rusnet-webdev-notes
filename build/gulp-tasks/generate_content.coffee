$        = (require 'gulp-load-plugins')()
gulpsync = $.sync gulp
config   = (require './config.coffee')()
gulp     = require 'gulp'
path     = require 'path'
del      = require 'del'

gulp.task 'gen_js', ->
  gulp.src path.join config.dev_path_static, '*.coffee'
    .pipe $.coffee({bare: true}).on 'error', $.util.log
    .pipe gulp.dest config.prod_path_static

gulp.task 'gen_markdown', ->
  gulp.src path.join config.database_path, '-markdown.md'
    .pipe $.markdown()
    .pipe gulp.dest config.dev_path_static

gulp.task 'gen_html', (cb) ->
  gulp.src path.join config.dev_path_static, '*.html'
    .pipe $.htmlincluder()
    .pipe gulp.dest config.prod_path_static
  cb()

gulp.task 'gen_clean', (cb) ->
  del path.join(config.dev_path_static, '-markdown.html'), {force: true}, cb

gulp.task 'generate_content', gulpsync.sync [
  'gen_js'
  'gen_markdown'
  'gen_html'
  'gen_clean'
]
