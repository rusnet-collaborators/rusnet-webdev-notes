$('h1').addClass 'page-header'
items = $('h1')
menu = $('#menu').find('ul')
for i in items
  do (i) ->
    text_wrap = $(i).text()
    li = document.createElement('li')
    $(li).attr('role', 'presentation')
    link_menu = document.createElement('a')
    link_anchor = document.createElement('a')
    $(link_anchor)
      .attr('name', text_wrap)
      .text(text_wrap)
    $(i).text('').append(link_anchor)
    $(link_menu)
      .attr('href', '#' + text_wrap )
      .attr('role', 'menuitem')
      .attr('tabindex', '-1')
      .text(text_wrap)
    $(li).append(link_menu)
    $(menu).append(li)

notes = $('#notes_wrap').find('a')
for i in notes
  do (i) ->
    $(i).attr('target', '_blank')
    $('<br/>').insertAfter(i)
