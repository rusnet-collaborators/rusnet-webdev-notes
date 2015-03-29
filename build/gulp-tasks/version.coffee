gutil = require('gulp-util');
exec = require('child_process').exec;



$ = (require 'gulp-load-plugins')()

gulp = require 'gulp'

config = (require './config.coffee')()

p = require 'path'

gulp.task 'version', ->

  getGitCommitCount = (opt, cb) -> 
    if (!cb || typeof cb != 'function') 
      cb = () ->
    if (!opt)
      opt = {}
    if (!opt.args) 
      opt.args = ' '
    if (!opt.cwd)
      opt.cwd = process.cwd()

    cmd = 'git rev-parse --count master'
    exec cmd, cwd: opt.cwd, (err, stdout, stderr) ->
      if (err)
        return cb(err)
      if (stdout)
        stdout = stdout.trim()
      cb(err, stdout)
      return
    return


  getGitCommitCount {}, (err, data) -> 
    console.log(data)
    return
