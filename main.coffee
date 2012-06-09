draw = (state)->
  canvas = $('#board')[0]
  
  if canvas.getContext
    ctx = canvas.getContext('2d')
    ctx.clearRect(0, 0, 2000, 2000 )
    rectangles = $('#' + state + '-values').val().replace(/\(/g,'').replace(/\)/g,'').replace(/INFO logger:/g, '').split('\n')
    for rectangle, index in rectangles
      coords = rectangle.split(',')
      drawRectangle(Number(coords[0]), Number(coords[1]), Number(coords[2]), Number(coords[3]), ctx, color(index))


color = (index)->
  color_list = ['red', 'green', 'blue', 'orange', 'black', 'purple', 'pink', 'yellow']
  color_list[index % color_list.length]

drawRectangle = (top, left, bottom, right, ctx, color)-> 
  ctx.strokeStyle = color
  ctx.strokeRect(left, top, (right-left), (bottom-top))
  
keys = ['before-values', 'after-values']

saveToCookies = ->
  for key in keys
    $.cookie(key, $('#' + key).val());
    
fillFromCookies =->
  for key in keys
    if $.cookie(key)
      $('#' + key).val($.cookie(key))
  
addEvents = ->
  $('#swap').click ->
    if $('#current-state').data('active') == 'before'
      $('#current-state').data('active','after')
      $('#current-state').html('After')
      draw('after')
    else
      $('#current-state').data('active', 'before')
      $('#current-state').html('Before')
      draw('before')
    
    saveToCookies()
    return false

$(document).ready ->
  fillFromCookies()
  addEvents()