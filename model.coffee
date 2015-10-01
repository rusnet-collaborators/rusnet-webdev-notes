hi_all = (msg) ->
  msg

item =
  first: null
  second: null
  full: null
  signal: hi_all

Object.defineProperty item, 'full',
  get: ->
    @first + ' ' + @second

  set: (name) ->
    name    = name.split ' '
    @first  = name[0] || ''
    @second = name[1] || ''
    return

module.exports = item
