$ ->
  window.chat = new Vue
    el: '#chat'
    data:
      messages: []
    compiled: ->
      @start()
    methods:
      subscribePath: ->
        $(@$el).data('subscribe')
      add: (message) ->
        @messages.push(message)
      start: ->
        console.log 'start establish connection'
        unless @subscribePath()
          console.log '[ERROR] subscribePath not found'
          return
        source = new EventSource(@subscribePath())
        source.onopen = (e) =>
          console.log "connection open: #{@subscribePath()}"
        source.onmessage =  (e) =>
          message = $.parseJSON(e.data)
          @add(message)

  $('#new_message').on 'ajax:success', (data, status, xhr) ->
