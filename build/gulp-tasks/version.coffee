$ = (require 'gulp-load-plugins')()

gulp = require 'gulp'

config = (require './config.coffee')()

p = require 'path'
exec = require('child_process').exec;


gulp.task 'version', (_cb) ->

  getGitCommitCount = (opt, cb) -> 
    if (!cb || typeof cb != 'function') 
      cb = () ->
    if (!opt)
      opt = {}
    if (!opt.args) 
      opt.args = ' '
    if (!opt.cwd)
      opt.cwd = process.cwd()

    cmd = 'git rev-list --count origin'
    exec cmd, cwd: opt.cwd, (err, stdout, stderr) ->
      if (err)
        return cb(err)
      if (stdout)
        stdout = stdout.trim()
      cb(err, stdout)
      return
    return


  getGitCommitCount {}, (err, data) ->
    gulp.src p.join config.prod_path_static, 'index.html'
      .pipe($.replace(/{{build}}/g, data))
      .pipe gulp.dest config.prod_path_static
    _cb()
    return