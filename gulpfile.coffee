$            = (require 'gulp-load-plugins')()
gulp         = require 'gulp'
gulpsync     = $.sync gulp
path         = require 'path'
config       = require './config.coffee'
del          = require 'del'
htmlincluder = require 'gulp-htmlincluder'

gulp.task 'clean', ->
  del config.prod_path, force: true
  return

gulp.task 'gen_js', ->
  gulp.src path.join config.dev_path_coffee, '*.coffee'
    .pipe $.coffee(
      bare: true
    ).on 'error', $.util.log
    .pipe gulp.dest path.join config.prod_path_js
  return

gulp.task 'gen_css', ->
  gulp.src path.join config.dev_path_sass, '*.sass'
    .pipe $.sass indentedSyntax: true
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

gulp.task 'gen_markdown', ->
  gulp.src path.join config.database_path, '*.md'
    .pipe $.markdown()
    .pipe gulp.dest config.dev_path
  return

gulp.task 'gen_html', ->
  gulp.src path.join config.dev_path, '*.html'
    .pipe htmlincluder()
    .pipe gulp.dest config.prod_path
  return

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

gulp.task 'predeploy', ->
  gulp.src path.join config.dev_path, 'CNAME'
    .pipe gulp.dest config.prod_path

gulp.task 'deploy', ['predeploy'], $.shell.task [ 'surge ' + config.prod_path ]

gulp.task 'default', gulpsync.sync [
  'clean'
  'gen_js'
  'gen_css'
  'gen_markdown'
  'gen_html'
  'copy'
  'deploy'
]
