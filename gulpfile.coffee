gulp         = require('gulp')
gulpsync     = require('gulp-sync')(gulp)
shell        = require('gulp-shell')
markdown     = require('gulp-markdown')
includer     = require('gulp-htmlincluder')
sass         = require('gulp-sass')
coffee       = require('gulp-coffee')
gutil        = require('gulp-util')

gulp.task 'gen_css', ->
  gulp.src('src/*.scss')
    .pipe sass()
    .pipe gulp.dest 'dist/'

gulp.task 'gen_js', ->
  gulp.src('src/*.coffee')
    .pipe coffee({bare: true}).on('error', gutil.log)
    .pipe gulp.dest 'dist/'

gulp.task 'gen_markdown', ->
  gulp.src('-markdown.md')
    .pipe markdown()
    .pipe gulp.dest 'src/'

gulp.task 'gen_html', ->
  gulp.src('src/*.html')
    .pipe includer()
    .pipe gulp.dest 'dist/'

gulp.task 'deploy', shell.task [ 'surge ./dist -d rusnet-webdev.surge.sh' ]

gulp.task 'default', gulpsync.sync [
  'gen_css'
  'gen_js'
  'gen_markdown'
  'gen_html'
  'deploy'
]