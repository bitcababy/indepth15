(($) ->
  $.generateId = ->
    arguments_.callee.prefix + arguments_.callee.count++

  $.generateId.prefix = "jq$"
  $.generateId.count = 0
  $.fn.generateId = ->
    @each ->
      @id = $.generateId()

) jQuery