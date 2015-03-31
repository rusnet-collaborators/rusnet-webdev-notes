gulp = require 'gulp'
path = require 'path'

require('require-dir')(path.join(__dirname, 'gulp-tasks'))

gulp.task 'default', ->
  gulp.start 'build_and_deploy'
