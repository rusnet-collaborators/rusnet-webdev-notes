gulp         = require('gulp')
$            = require('gulp-load-plugins')()
gulpsync     = $.sync(gulp)

del = require('del');

gulp.task 'clean', (cb) ->
  del('dist', cb)


gulp.task 'copy_css', ->
  gulp.src('src/*.css')
    .pipe gulp.dest 'dist/'

gulp.task 'copy_image', ->
  gulp.src('src/*.png')
    .pipe gulp.dest 'dist/'

gulp.task 'gen_js', ->
  gulp.src('src/*.coffee')
    .pipe $.coffee({bare: true}).on('error', $.util.log)
    .pipe gulp.dest 'dist/'

gulp.task 'gen_markdown', ->
  gulp.src('-markdown.md')
    .pipe $.markdown()
    .pipe gulp.dest 'src/'

gulp.task 'gen_html',  (cb) ->
  gulp.src('src/*.html')
    .pipe $.htmlincluder()
    .pipe gulp.dest 'dist/'
  del('src/-markdown.html', cb)  

gulp.task 'predeploy', ->
  gulp.src 'CNAME'
    .pipe gulp.dest 'dist/'

gulp.task 'deploy', ['predeploy'], $.shell.task [ 'surge ./dist' ]

gulp.task 'default', gulpsync.sync [
  'clean'
  'copy_css'
  'copy_image'
  'gen_js'
  'gen_markdown'
  'gen_html'
  'deploy'
]
