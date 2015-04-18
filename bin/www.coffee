normalizePort = (val) ->
  port = parseInt(val, 10)
  if isNaN(port)
    # named pipe
    return val
  if port >= 0
    # port number
    return port
  false

onError = (error) ->
  if error.syscall != 'listen'
    throw error
  bind = if typeof port == 'string' then 'Pipe ' + port else 'Port ' + port
  # handle specific listen errors with friendly messages
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
  bind = if typeof addr == 'string' then 'pipe ' + addr else 'port ' + addr.port
  debug 'Listening on ' + bind
  return

require('coffee-script').register()
app = require('../app')
debug = require('debug')('app:server')
http = require('http')

port = normalizePort(process.env.PORT or '40002')
app.set 'port', port

server = http.createServer(app)
server.listen port
server.on 'error', onError
server.on 'listening', onListening