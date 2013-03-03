$.fn.dataTableExt.oPagination.four_button =
  fnInit: (oSettings, nPaging, fnCallbackDraw) ->
    nFirst = document.createElement("span")
    nPrevious = document.createElement("span")
    nNext = document.createElement("span")
    nLast = document.createElement("span")
    nFirst.appendChild document.createTextNode(oSettings.oLanguage.oPaginate.sFirst)
    nPrevious.appendChild document.createTextNode(oSettings.oLanguage.oPaginate.sPrevious)
    nNext.appendChild document.createTextNode(oSettings.oLanguage.oPaginate.sNext)
    nLast.appendChild document.createTextNode(oSettings.oLanguage.oPaginate.sLast)
    nFirst.className = "paginate_button first"
    nPrevious.className = "paginate_button previous"
    nNext.className = "paginate_button next"
    nLast.className = "paginate_button last"
    nPaging.appendChild nFirst
    nPaging.appendChild nPrevious
    nPaging.appendChild nNext
    nPaging.appendChild nLast
    $(nFirst).click ->
      oSettings.oApi._fnPageChange oSettings, "first"
      fnCallbackDraw oSettings

    $(nPrevious).click ->
      oSettings.oApi._fnPageChange oSettings, "previous"
      fnCallbackDraw oSettings

    $(nNext).click ->
      oSettings.oApi._fnPageChange oSettings, "next"
      fnCallbackDraw oSettings

    $(nLast).click ->
      oSettings.oApi._fnPageChange oSettings, "last"
      fnCallbackDraw oSettings

    
    # Disallow text selection 
    $(nFirst).bind "selectstart", ->
      false

    $(nPrevious).bind "selectstart", ->
      false

    $(nNext).bind "selectstart", ->
      false

    $(nLast).bind "selectstart", ->
      false


  fnUpdate: (oSettings, fnCallbackDraw) ->
    return  unless oSettings.aanFeatures.p
    
    # Loop over each instance of the pager 
    an = oSettings.aanFeatures.p
    i = 0
    iLen = an.length

    while i < iLen
      buttons = an[i].getElementsByTagName("span")
      if oSettings._iDisplayStart is 0
        buttons[0].className = "paginate_disabled_previous"
        buttons[1].className = "paginate_disabled_previous"
      else
        buttons[0].className = "paginate_enabled_previous"
        buttons[1].className = "paginate_enabled_previous"
      if oSettings.fnDisplayEnd() is oSettings.fnRecordsDisplay()
        buttons[2].className = "paginate_disabled_next"
        buttons[3].className = "paginate_disabled_next"
      else
        buttons[2].className = "paginate_enabled_next"
        buttons[3].className = "paginate_enabled_next"
      i++