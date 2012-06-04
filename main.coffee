drawAfter = ->
  canvas = $('#board')[0]
  
  if canvas.getContext
    ctx = canvas.getContext('2d')
    ctx.clearRect(0, 0, 2000, 2000 )
    drawRectangle($('#after_box1_t').val(), $('#after_box1_l').val(), $('#after_box1_b').val(), $('#after_box1_r').val(), ctx, 'red')
    drawRectangle($('#after_box2_t').val(), $('#after_box2_l').val(), $('#after_box2_b').val(), $('#after_box2_r').val(), ctx, 'green') 

drawBefore = ->
  canvas = $('#board')[0]

  if canvas.getContext
    ctx = canvas.getContext('2d')
    ctx.clearRect(0, 0, 2000, 2000 )
    drawRectangle($('#before_box1_t').val(), $('#before_box1_l').val(), $('#before_box1_b').val(), $('#before_box1_r').val(), ctx, 'red')
    drawRectangle($('#before_box2_t').val(), $('#before_box2_l').val(), $('#before_box2_b').val(), $('#before_box2_r').val(), ctx, 'green') 


drawRectangle = (top, left, bottom, right, ctx, color)-> 
  ctx.strokeStyle = color
  ctx.strokeRect(left, top, (right-left), (bottom-top))
  
keys = ['before_box1_t', 'before_box1_l', 'before_box1_b', 'before_box1_r',
        'before_box2_t', 'before_box2_l', 'before_box2_b', 'before_box2_r',
        'after_box1_t', 'after_box1_l', 'after_box1_b', 'after_box1_r',
        'after_box2_t', 'after_box2_l', 'after_box2_b', 'after_box2_r']

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
      drawAfter()
    else
      $('#current-state').data('active', 'before')
      $('#current-state').html('Before')
      drawBefore()
    
    saveToCookies()
    return false

$(document).ready ->
  fillFromCookies()
  addEvents()