$        = (require 'gulp-load-plugins')()
config   = (require './config.coffee')()
gulp     = require 'gulp'
gulpsync = $.sync gulp
path     = require 'path'
del      = require 'del'
htmlincluder = require 'gulp-htmlincluder'

gulp.task 'gen_js', ->
  gulp.src path.join config.dev_path_coffee, '*.coffee'
    .pipe $.coffee({bare: true}).on 'error', $.util.log
    .pipe gulp.dest path.join config.prod_path_js

gulp.task 'gen_css', ->
  gulp.src path.join config.dev_path_sass, '*.sass'
    .pipe $.sass( {indentedSyntax: true} )
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
    .pipe gulp.dest config.dev_path_static

gulp.task 'gen_html', (cb) ->
  gulp.src path.join config.dev_path_static, '*.html'
    .pipe htmlincluder()
    .pipe gulp.dest config.prod_path_static
  cb()

gulp.task 'generate_content', gulpsync.sync [
  'gen_js'
  'gen_css'
  'gen_markdown'
  'gen_html'
]
