gulp     = require('gulp')
gulpsync = require('gulp-sync')(gulp)
shell    = require('gulp-shell')
markdown = require('gulp-markdown')
includer = require('gulp-htmlincluder')

gulp.task 'build', ->
  gulp.src('-markdown.md')
    .pipe markdown()
    .pipe gulp.dest('src/')

gulp.task 'generate', ->
  gulp.src('src/*.html')
    .pipe includer()
    .pipe gulp.dest('dist/')

gulp.task 'deploy', shell.task([ 'surge ./dist -d rusnet-webdev.surge.sh' ])

gulp.task 'default', gulpsync.sync([
    'build'
    'generate'
    'deploy'
])
