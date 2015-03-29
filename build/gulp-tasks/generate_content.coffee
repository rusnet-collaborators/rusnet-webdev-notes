$ = (require 'gulp-load-plugins')()

gulp     = require 'gulp'
gulpsync = $.sync gulp

config = (require './config.coffee')()

del = require 'del'
p   = require 'path'


gulp.task 'gen_js', ->
  gulp.src p.join config.dev_path_static, '*.coffee'
    .pipe $.coffee({bare: true}).on 'error', $.util.log
    .pipe gulp.dest config.prod_path_static

gulp.task 'gen_markdown', ->
  gulp.src p.join config.database_path, '-markdown.md'
    .pipe $.markdown()
    .pipe gulp.dest config.dev_path_static

gulp.task 'gen_html', (cb) ->
  gulp.src p.join config.dev_path_static, '*.html'
    .pipe $.htmlincluder()
    .pipe gulp.dest config.prod_path_static
  cb()

gulp.task 'gen_clean', (cb) ->
  del p.join(config.dev_path_static, '-markdown.html'), {force: true}, cb

gulp.task 'generate_content', gulpsync.sync ['gen_js', 'gen_markdown', 'gen_html', 'gen_clean']
