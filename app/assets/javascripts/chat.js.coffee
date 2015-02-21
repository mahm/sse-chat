$ ->
  $messages = $('#messages')
  subscribePath = $messages.data('subscribe')
  if subscribePath
    source = new EventSource(subscribePath)
    source.onopen = (e) ->
      console.log "connection open"
    source.onmessage =  (e) ->
      message = $.parseJSON(e.data)
      $('#messages').append($('<li>').text("#{message.name}: #{message.content}"))

  $('#new_message').on 'ajax:success', (data, status, xhr) ->
