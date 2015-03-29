$('h1').addClass 'page-header'
items = $('h1')
menu = $('#menu').find('ul')
for i in items
  do (i) ->
    text_wrap = i.textContent
    li = document.createElement('li')
    $(li).attr('role', 'presentation')

    count_link = document.createElement('span')
    $(count_link)
      .attr('class', 'badge pull-right')
      .text( $(i).nextUntil('h1').find('a').length )

    link_menu = document.createElement('a')
    $(link_menu)
      .attr('href', '#' + text_wrap )
      .attr('role', 'menuitem')
      .attr('tabindex', '-1')
      .text(text_wrap)
      .append(count_link)

    link_anchor = document.createElement('a')
    $(link_anchor)
      .attr('name', text_wrap)
      .attr('href', '#' + text_wrap)
      .attr('class', 'block')
      .text(text_wrap)

    $(i).text('').append(link_anchor)
    $(li).append(link_menu)
    $(menu).append(li)

notes = $('#notes_wrap p a')
for i in notes
  do (i) ->
    $(i).attr('target', '_blank')
      .text( i.textContent.replace(/(http|https):\/\/(www){0,1}\.{0,1}/, '') )
    $('<br/>').insertAfter(i)
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

