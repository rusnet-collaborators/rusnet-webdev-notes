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
    return

  $('[data-command="study-increase"]').on 'click', (event) ->
    event = event || window.event
    target = event.target || event.srcElement
    event.preventDefault()

    if $(target).attr('data-uid') is undefined
      target = $(target).parent()
    uid = $(target).attr 'data-uid'
    progress = $('.progress-bar[data-function="study"][data-uid="' + uid + '"]')
    percent = parseInt $(progress).attr 'aria-valuenow'

    if percent < 100
      percent += 1

    set_percent progress, percent

    input = $('input[data-function="study"]').val percent
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

  return
