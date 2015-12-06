storage = Object.create null

localStorage = ls = window.localStorage

localStorageDriver = lsd = {}

sensors = s =
  foo: "bar"

gen_uid =
  count: {}

  init: ->
    return

  get: (key) ->
    if @count[key] is undefined
      @count[key] = 0

    c = @count[key]
    @count[key] += 1
    key + '_' + c

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

class List
  constructor: (@name, @description, @items = []) ->
    @uid = gen_uid.get @constructor.name.toLowerCase()

$ ->
  $('.description').on 'mousewheel', (event) ->
    event = event || window.event
    target = event.target || event.srcElement

    if $(target).attr('class') is 'description'
      target = $(target).find 'p'

    top_first = parseInt $(target).css('top')
    height = $(target).height()
    parent_height = $(target).parent().height()

    wheel = event.originalEvent.wheelDelta

    if wheel > 0
      top = top_first + 10
      if top <= 0
        $(target).css('top', top + 'px' )
    else if wheel < 0
      top = top_first - 10
      if Math.abs( top ) < height - parent_height
        $(target).css('top', top + 'px' )

    return

  $('[data-command="item_settings"]').on 'click', (event) ->
    event = event || window.event
    target = event.target || event.srcElement
    if $(target).attr('data-uid') is undefined
      target = $(target).parent()

    uid = $(target).attr 'data-uid'

    $('[role="panel_settings"][data-uid="' + uid + '"]').toggle()
    return

  set_percent = (element, data) ->
    width = data + '%'
    $(element)
      .css 'width', width
      .attr 'aria-valuenow', data

    input = $('input[data-function="study"]').val data
    return

  mousehold =
    count: ->
      if @command is 'increase' and @percent < 100
        @percent += 1
      else if @command is 'decrease' and @percent > 0
        @percent -= 1
      set_percent @progress, @percent
      return

    run: ->
      @interval = setInterval @count.bind(@), 50
      return

    run_interval: ->
      @timeout = setTimeout @run.bind(@), 500
      return

    clear: ->
      clearInterval @interval
      clearTimeout @timeout
      clearInterval @interval
      clearTimeout @timeout
      return

  $('[data-command^="study-"]')
    .on 'click', (event) ->
      event = event || window.event
      target = event.target || event.srcElement
      event.preventDefault()

      if $(target).attr('data-uid') is undefined
        target = $(target).parent()
      uid = $(target).attr 'data-uid'
      progress = $('.progress-bar[data-function="study"][data-uid="' + uid + '"]')
      percent = parseInt $(progress).attr 'aria-valuenow'
      command = $(target).attr('data-command').split('-')[1]

      if command is 'increase' and percent < 100
        percent += 1
      else if command is 'decrease' and percent > 0
        percent -= 1

      set_percent progress, percent

      return

    .on 'mousedown', (event) ->
      event = event || window.event
      target = event.target || event.srcElement

      if $(target).attr('data-uid') is undefined
        target = $(target).parent()
      uid = $(target).attr 'data-uid'
      progress = $('.progress-bar[data-function="study"][data-uid="' + uid + '"]')
      percent = parseInt $(progress).attr 'aria-valuenow'
      command = $(target).attr('data-command').split('-')[1]

      mousehold.progress = progress
      mousehold.percent  = percent
      mousehold.command  = command
      mousehold.run_interval()
      return

    .on 'mouseup mouseleave mouseout', (event) ->
      mousehold.clear()
      return

  $('input[data-function="study"]')
    .on 'change', (event) ->
      event = event || window.event
      target = event.target || event.srcElement
      uid = $(target).attr 'data-uid'
      value = $(target).val()
      if /^[0-9]{1,}$/.test(value) and parseInt(value) >= 0 and parseInt(value) <= 100
        progress = $('.progress-bar[data-function="study"][data-uid="' + uid + '"]')
        set_percent progress, parseInt(value)
      return

    .on 'input', (event) ->
      event = event || window.event
      target = event.target || event.srcElement
      uid = $(target).attr 'data-uid'
      value = $(target).val()
      if /^[0-9]{1,}$/.test(value) and parseInt(value) >= 0 and parseInt(value) <= 100
        progress = $('.progress-bar[data-function="study"][data-uid="' + uid + '"]')
        set_percent progress, parseInt(value)
      return

  $.ajax
    url: 'template.html'
    type: 'GET'
    success: (data) ->
      $('.main').append(data)
      return

  return
