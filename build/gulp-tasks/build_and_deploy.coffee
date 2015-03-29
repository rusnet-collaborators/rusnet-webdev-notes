$ = (require 'gulp-load-plugins')()

gulp     = require 'gulp'
gulpsync = $.sync gulp

config = (require './config.coffee')()

del = require 'del'


gulp.task 'clean', (cb) ->
  del config.prod_path_static, force: true, cb


gulp.task 'build_and_deploy', gulpsync.sync [
  'clean'
  'copy_static'
  'generate_content'
  'version'
  'deploy'
]
