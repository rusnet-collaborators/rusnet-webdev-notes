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

    console.log target
    uid = $(target).attr 'data-uid'
    console.log "uid: " + uid

    $('[role="panel_settings"][data-uid="' + uid + '"]').toggle()
    return
  return
