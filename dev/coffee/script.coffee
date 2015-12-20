ls = window.localStorage

if ls['rstorage']
  rstorage = JSON.parse ls['rstorage']
else
  rstorage = window.rstorage = Object.create null

localStorageDriver = lsd = {}

current_item = {}

html_string = ""

sensors = s =
  foo: "bar"

gen_uid =
  count: {}

  init: ->
    if ls['gen_uid_count']
      @count = JSON.parse(ls['gen_uid_count'])
    return

  save: ->
    data = JSON.stringify @count
    ls['gen_uid_count'] = data
    return

  get: (key) ->
    if @count[key] is undefined
      @count[key] = 0

    c = @count[key]
    @count[key] += 1
    @save()
    key + ':' + c

class Item
  constructor: (@uid, @url, @uri, @url_raw, @description, @tags_uid = [], @list_uid = []) ->
    @type = @constructor.name.toLowerCase()

  set_uid: (uid) ->
    if uid
      @uid = uid
    else
      @uid = gen_uid.get @constructor.name.toLowerCase()
    return

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

  draw: ->
    html = $(html_string)
    $(html).find('[r-for="item url"]').attr 'href', @url
    $(html).find('[r-for="item url"]').text @uri
    $(html).find('[r-for="item description"]').text @description
    $('.main').append(html)
    return

  save: ->
    json = JSON.stringify(@)
    if rstorage[@type] is undefined then rstorage[@type] = []
    rstorage[@type].push @uid
    ls[@uid] = json
    ls['rstorage'] = JSON.stringify(rstorage[@type])
    @draw()
    return


class Tag
  constructor: (@name, @items = []) ->
    @uid = gen_uid.get @constructor.name.toLowerCase()

class List
  constructor: (@name, @description, @items = []) ->
    @uid = gen_uid.get @constructor.name.toLowerCase()

items_init = ->
  raw_items = Object.keys ls
  raw_items = raw_items.filter (el) ->
    if /item/.test(el) is true
      return true
    else
      return false

  raw_items.forEach (el) ->
    item_raw = JSON.parse ls[el]
    item = new Item
    item.set_uid item_raw.uid
    item.set_url item_raw.url_raw
    item.set_description item_raw.description
    item.draw()
    return
  return

$ ->
  $('.description').on 'mousewheel', (event) ->
    event = event or window.event
    target = event.target or event.srcElement

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
    event = event or window.event
    target = event.target or event.srcElement
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
      event = event or window.event
      target = event.target or event.srcElement
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
      event = event or window.event
      target = event.target or event.srcElement

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
      event = event or window.event
      target = event.target or event.srcElement
      uid = $(target).attr 'data-uid'
      value = $(target).val()
      if /^[0-9]{1,}$/.test(value) and parseInt(value) >= 0 and parseInt(value) <= 100
        progress = $('.progress-bar[data-function="study"][data-uid="' + uid + '"]')
        set_percent progress, parseInt(value)
      return

    .on 'input', (event) ->
      event = event or window.event
      target = event.target or event.srcElement
      uid = $(target).attr 'data-uid'
      value = $(target).val()
      if /^[0-9]{1,}$/.test(value) and parseInt(value) >= 0 and parseInt(value) <= 100
        progress = $('.progress-bar[data-function="study"][data-uid="' + uid + '"]')
        set_percent progress, parseInt(value)
      return

  $('[r-command]').on 'click', (event) ->
    event = event or window.event
    target = event.target or event.srcElement
    command = $(target).attr('r-command')

    if command is 'save_item'
      item = new Item
      item.set_uid()
      item.set_url current_item.rawurl
      item.set_description current_item.description
      item.save()
      current_item = {}
      $('.modal.fade.in').modal 'hide'

    if command is 'clear_local_storage'
      ls.clear()
      location.reload()

    return

  $('.modal').on 'hidden.bs.modal', (event) ->
    event = event or window.event
    target = event.target or event.srcElement

    $('[r-write]').each (index, el) ->
      $(el).val ''
      return

    return

  $('[r-write]').on 'change input keypress', (event) ->
    event = event or window.event
    target = event.target or event.srcElement
    write_for = $(target).attr 'r-write'
    object = write_for.split(' ')[0]
    field = write_for.split(' ')[1]

    if object is 'item'
      current_item[field] = $(target).val()

    return

  $.ajax
    url: 'template.html'
    type: 'GET'
    success: (data) ->
      html_string = data
      items_init()
      gen_uid.init()
      return

  return
