$        = (require 'gulp-load-plugins')()
config   = require './config.coffee'
del      = require 'del'
gulp     = require 'gulp'
gulpsync = $.sync gulp
path     = require 'path'
colors   = require 'colors'
util     = require 'util'

gulp.task 'clean', ->
  del config.prod_path,
    force: true

gulp.task 'copy_dir', ->
  gulp.src path.join(config.dev_path_img, '**/*'),   base: config.dev_path
    .pipe gulp.dest config.prod_path
  gulp.src path.join(config.dev_path_js, '**/*'),    base: config.dev_path
    .pipe gulp.dest config.prod_path
  gulp.src path.join(config.dev_path_css, '**/*'),   base: config.dev_path
    .pipe gulp.dest config.prod_path
  gulp.src path.join(config.dev_path_json, '**/*'),  base: config.dev_path
    .pipe gulp.dest config.prod_path
  gulp.src path.join(config.dev_path_fonts, '**/*'), base: config.dev_path
    .pipe gulp.dest config.prod_path
  return

gulp.task 'gen_js', ->
  gulp.src path.join config.dev_path_coffee, '*.coffee'
    .pipe $.coffee( bare: true ).on 'error', $.util.log
    .pipe gulp.dest config.prod_path_js

gulp.task 'gen_js_livereload', ->
  gulp.src path.join config.dev_path_coffee, '*.coffee'
    .pipe $.coffee( bare: true ).on 'error', $.util.log
    .pipe gulp.dest config.prod_path_js
    .pipe $.livereload()

gulp.task 'gen_css', ->
  gulp.src path.join(config.dev_path_sass, '*.sass')
    .pipe $.sass( indentedSyntax: true )
    .pipe $.autoprefixer
      browsers: [
        'Firefox ESR'
        'Firefox 14'
        'Opera 10'
        'last 2 version'
        'safari 5'
        'ie 8'
        'ie 9'
        'opera 12.1'
        'ios 6'
        'android 4'
      ]
      cascade: true
    .pipe gulp.dest config.prod_path_css

gulp.task 'gen_css_livereload', ->
  gulp.src path.join(config.dev_path_sass, '*.sass')
    .pipe $.sass( indentedSyntax: true )
    .pipe $.autoprefixer
      browsers: [
        'Firefox ESR'
        'Firefox 14'
        'Opera 10'
        'last 2 version'
        'safari 5'
        'ie 8'
        'ie 9'
        'opera 12.1'
        'ios 6'
        'android 4'
      ]
      cascade: true
    .pipe gulp.dest config.prod_path_css
    .pipe $.livereload()

gulp.task 'gen_html', ->
  gulp.src path.join config.dev_path, '*.ejs'
    .pipe $.ejs()
    .pipe gulp.dest config.prod_path
  return

gulp.task 'gen_html_livereload', ->
  gulp.src path.join config.dev_path, '*.ejs'
    .pipe $.ejs()
    .pipe gulp.dest config.prod_path
    .pipe $.livereload()
  return

gulp.task 'copy_json_livereload', ->
  gulp.src path.join(config.dev_path_json, '**/*'), base: config.dev_path
    .pipe gulp.dest config.prod_path
    .pipe $.livereload()

gulp.task 'watcher', ->
  $.livereload.listen
    port: 35729
  gulp.watch path.join(config.dev_path_sass, '*.sass'),
    ['gen_css_livereload']
  gulp.watch path.join(config.dev_path_coffee, '*.coffee'),
    ['gen_js_livereload']
  gulp.watch path.join(config.dev_path_json, '*.json'),
    ['copy_json_livereload']
  gulp.watch path.join(config.dev_path, '*.ejs'),
    ['gen_html_livereload']
  gulp.watch path.join(config.dev_path_ejs, '*.ejs'),
    ['gen_html_livereload']
  return

gulp.task 'default', gulpsync.sync [
  'clean'
  'copy_dir'
  'gen_js'
  'gen_css'
  'gen_html'
]

gulp.task 'watch', gulpsync.sync [
  'watcher'
]
