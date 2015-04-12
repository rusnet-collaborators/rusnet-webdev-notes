$        = (require 'gulp-load-plugins')()
config   = (require './config.coffee')()
gulp     = require 'gulp'
gulpsync = $.sync gulp
del      = require 'del'

gulp.task 'clean', (cb) ->
  del config.prod_path_static, force: true, cb

gulp.task 'build_and_deploy', gulpsync.sync [
  'clean'
  'generate_content'
  'copy_static'
  'version'
  'deploy'
]
