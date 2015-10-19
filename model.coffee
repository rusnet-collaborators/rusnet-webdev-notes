localStorage = ls =
  set: (key, value) ->
    if typeof value is 'string'
      @[key] = value
    else if typeof value is 'number' or typeof value is 'boolean' or typeof value is 'object'
      try
        @[key] = JSON.stringify value
      catch err
        console.log err

    if @[key]
      return true
    else
      return false

  get: (key) ->
    if @[key]
      return @[key]
    else
      return false

gen_uid =
  count: {}

  init: ->
    return

  get: (key) ->
    if @count[key] is undefined
      @count[key] = 0

    c = @count[key]
    @count[key] += 1
    return key + '_' + c

class Item
  constructor: (@url, @uri, @url_raw, @description, @tags_uid = [], @header_uid = [], @list_uid = []) ->
    @uid = gen_uid.get @constructor.name.toLowerCase()

  set_url: (url) ->
    @url_raw = url.trim()
    if typeof url is 'string'
      url = url.trim().split '://'
      index = url.length - 1
      @uri = uri = url[index].replace /\/$/, ''
      @url_type = url_type = url[0]
      @url = url_type + '://' + uri
      return true
    else
      return false

  set_description: (data) ->
    if typeof data is 'string'
      @description = data.trim()
      return true
    else
      return false

  add_relation: (item) ->
    if item is undefined
      return false
    else
      name_item = item.constructor.name.toLowerCase()
      if name_item is 'tag'
        @

class Tag
  constructor: (@name, @items = []) ->
    @uid = gen_uid.get @constructor.name.toLowerCase()

class Header
  constructor: (@name, @description, @items = []) ->
    @uid = gen_uid.get @constructor.name.toLowerCase()

class List
  constructor: (@name, @description, @items = []) ->
    @uid = gen_uid.get @constructor.name.toLowerCase()

storage = Object.create null

module.exports =
  item: Item
  tag: Tag
  header: Header
  storage: storage
  get_uid: gen_uid
  localStorage: localStorage
