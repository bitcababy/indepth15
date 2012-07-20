(($) ->
  $.fn.hoverIntent = (overConfig, g) ->
    cfg =
      sensitivity: 7
      interval: 100
      timeout: 0

    cfg = $.extend(cfg, (if g then
      over: overConfig
      out: g
     else overConfig))
    cX = undefined
    cY = undefined
    pX = undefined
    pY = undefined
    track = (ev) ->
      cX = ev.pageX
      cY = ev.pageY

    compare = (ev, ob) ->
      ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t)
      if (Math.abs(pX - cX) + Math.abs(pY - cY)) < cfg.sensitivity
        $(ob).unbind "mousemove", track
        ob.hoverIntent_s = 1
        cfg.over.apply ob, [ ev ]
      else
        pX = cX
        pY = cY
        ob.hoverIntent_t = setTimeout(->
          compare ev, ob
        , cfg.interval)

    delay = (ev, ob) ->
      ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t)
      ob.hoverIntent_s = 0
      cfg.out.apply ob, [ ev ]

    handleHover = (e) ->
      ev = jQuery.extend({}, e)
      ob = this
      ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t)  if ob.hoverIntent_t
      if e.type is "mouseenter"
        pX = ev.pageX
        pY = ev.pageY
        $(ob).bind "mousemove", track
        unless ob.hoverIntent_s is 1
          ob.hoverIntent_t = setTimeout(->
            compare ev, ob
          , cfg.interval)
      else
        $(ob).unbind "mousemove", track
        if ob.hoverIntent_s is 1
          ob.hoverIntent_t = setTimeout(->
            delay ev, ob
          , cfg.timeout)

    @bind("mouseenter", handleHover).bind "mouseleave", handleHover
) jQuery