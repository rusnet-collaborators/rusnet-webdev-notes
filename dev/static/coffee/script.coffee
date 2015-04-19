Rusnet = ->
  return

Rusnet::init_view = ->
  $('#notes_wrap h1').addClass 'custom-h1-block'
  items = $('#notes_wrap h1')
  menu = $('#menu').find('ul')
  for i in items
    do (i) ->
      text_wrap = i.textContent
      link_wrap = text_wrap.trim()
      link_wrap = link_wrap.replace(/(\s|\.|,|:)/g, '_')
      link_wrap = link_wrap.replace(/_{2,}/g, '_').replace(/_$/g, '')
      link_wrap = link_wrap.replace(/_$/g, '')
      link_wrap = link_wrap.toLowerCase()
      li = document.createElement('li')
      $(li).attr('role', 'presentation')

      count_link = document.createElement('span')
      $(count_link)
        .attr('class', 'badge pull-right')
        .text( $(i).nextUntil('h1').find('a').length )

      link_menu = document.createElement('a')
      $(link_menu)
        .attr('href', '#' + link_wrap )
        .attr('role', 'menuitem')
        .attr('tabindex', '-1')
        .text(text_wrap)
        .append(count_link)

      link_anchor = document.createElement('a')
      $(link_anchor)
        .attr('name', link_wrap)
        .attr('href', '#' + link_wrap)
        .attr('class', 'block')
        .text(text_wrap)

      $(i).text('').append(link_anchor)
      $(li).append(link_menu)
      $(menu).append(li)

Rusnet::add_target_link = ->
  items = $('#notes_wrap p a')
  for i in items
    do (i) ->
      $(i).attr('target', '_blank')
        .text( i.textContent.replace(/(http|https):\/\/(www){0,1}\.{0,1}/, '') )
        .text( i.textContent.replace(/\/$/, '') )
      $('<br/>').insertAfter(i)

Rusnet::add_tag_link = ->
  tags = $('#notes_wrap ul li')
  for i in tags
    do (i) ->
      link_tag = document.createElement('a')
      $(link_tag)
        .attr('href', '#tag-' + i.textContent)
        .attr('class', 'white')
        .text(i.textContent)
      $(i)
        .attr('class', 'label label-primary')
        .text('')
        .append(link_tag)

Rusnet::hide_content = ->
  items = $('#notes_wrap h1')
  for i in items
    do (i) ->
      hide_items = $(i).nextUntil('h1')
      $(hide_items).hide()
      $(i).find('a').on 'click', (event) ->
        $(hide_items).toggle()
        return
      return

rusnet = new Rusnet()
rusnet.init_view()
rusnet.add_target_link()
rusnet.add_tag_link()
rusnet.hide_content()
