express        = require 'express'
path           = require 'path'
favicon        = require 'serve-favicon'
logger         = require 'morgan'
cookieParser   = require 'cookie-parser'
bodyParser     = require 'body-parser'
session        = require 'express-session'
methodOverride = require 'method-override'
util           = require 'util'
config         = require './config'

app = express()
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'ejs'
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: true

app.use cookieParser()
app.use session
  secret: '0987654321'
  name: 'rusnet_session'
  prozy: true
  resave: true
  saveUninitialized: true

app.use methodOverride()
app.use express.static config.prod_path
app.use (req, res, next) ->
  err = new Error 'Not Found'
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

module.exports = app
