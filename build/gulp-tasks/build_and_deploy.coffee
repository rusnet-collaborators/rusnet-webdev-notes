$        = (require 'gulp-load-plugins')()
gulpsync = $.sync gulp
config   = (require './config.coffee')()
gulp     = require 'gulp'
del      = require 'del'

gulp.task 'clean', (cb) ->
  del config.prod_path_static, force: true, cb

gulp.task 'build_and_deploy', gulpsync.sync [
  'clean'
  'copy_static'
  'generate_content'
  'version'
  'deploy'
]
