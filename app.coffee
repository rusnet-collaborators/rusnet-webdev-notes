express = require 'express'
path    = require 'path'
logger  = require 'morgan'
config  = require './config'
debug   = require('debug')('app:server')
http    = require 'http'

app = express()
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'ejs'
app.use logger 'dev'

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

normalizePort = (val) ->
  port = parseInt(val, 10)
  if isNaN(port) then return val
  if port >= 0 then return port

onError = (error) ->
  if error.syscall isnt 'listen' then throw error
  bind = if typeof port == 'string' then 'Pipe ' + port else 'Port ' + port
  switch error.code
    when 'EACCES'
      console.error bind + ' requires elevated privileges'
      process.exit 1
    when 'EADDRINUSE'
      console.error bind + ' is already in use'
      process.exit 1
    else
      throw error
  return

onListening = ->
  addr = server.address()
  bind = if typeof addr is 'string' then 'pipe: ' + addr else 'port: ' + addr.port
  debug 'Listening on ' + bind
  return

port = normalizePort(process.env.PORT or '3000')
app.set 'port', port

server = http.createServer(app)
server.listen port
server.on 'error', onError
server.on 'listening', onListening
