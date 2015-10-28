express      = require 'express'
path         = require 'path'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
app          = express()

app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'ejs'
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: false
app.use cookieParser()
app.use express.static path.join __dirname, 'prod'

app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return

if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err
    return

app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}
  return

module.exports = app
