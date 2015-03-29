gulp = require 'gulp'
p = require 'path'

require('require-dir')(p.join(__dirname, 'gulp-tasks'))

gulp.task 'default', ->
  gulp.start 'build_and_deploy'
