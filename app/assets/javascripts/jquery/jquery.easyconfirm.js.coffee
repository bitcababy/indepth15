###
jQuery Easy Confirm Dialog plugin 1.2

Copyright (c) 2010 Emil Janitzek (http://projectshadowlight.org)
Based on Confirm 1.3 by Nadia Alramli (http://nadiana.com/)

Samples and instructions at:
http://projectshadowlight.org/jquery-easy-confirm-dialog/

This script is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option)
any later version.
###
(($) ->
  $.easyconfirm = {}
  $.easyconfirm.locales = {}
  $.easyconfirm.locales.enUS =
    title: "Are you sure?"
    text: "Are you sure that you want to perform this action?"
    button: ["Cancel", "Confirm"]
    closeText: "close"

  $.easyconfirm.locales.svSE =
    title: "Är du säker?"
    text: "Är du säker på att du vill genomföra denna åtgärden?"
    button: ["Avbryt", "Bekräfta"]
    closeText: "stäng"

  $.easyconfirm.locales.itIT =
    title: "Sei sicuro?"
    text: "Sei sicuro di voler compiere questa azione?"
    button: ["Annulla", "Conferma"]
    closeText: "chiudi"

  $.fn.easyconfirm = (options) ->
    _attr = $.fn.attr
    $.fn.attr = (attr, value) ->
      
      # Let the original attr() do its work.
      returned = _attr.apply(this, arguments_)
      
      # Fix for jQuery 1.6+
      returned = ""  if attr is "title" and returned is `undefined`
      returned

    options = jQuery.extend(
      eventType: "click"
      icon: "help"
    , options)
    locale = jQuery.extend({}, $.easyconfirm.locales.enUS, options.locale)
    
    # Shortcut to eventType.
    type = options.eventType
    @each ->
      target = this
      $target = jQuery(target)
      
      # If no events present then and if there is a valid url, then trigger url change
      urlClick = ->
        if target.href
          length = String(target.href).length
          document.location = target.href  unless target.href.substring(length - 1, length) is "#"

      
      # If any handlers where bind before triggering, lets save them and add them later
      saveHandlers = ->
        events = jQuery.data(target, "events")
        if events
          target._handlers = new Array()
          $.each events[type], ->
            target._handlers.push this

          $target.unbind type

      
      # Re-bind old events
      rebindHandlers = ->
        if target._handlers isnt `undefined`
          jQuery.each target._handlers, ->
            $target.bind type, this


      locale.text = $target.attr("title")  if $target.attr("title") isnt null and $target.attr("title").length > 0
      dialog = (if (options.dialog is `undefined` or typeof (options.dialog) isnt "object") then $("<div class=\"dialog confirm\">" + locale.text + "</div>") else options.dialog)
      buttons = {}
      buttons[locale.button[1]] = ->
        
        # Unbind overriding handler and let default actions pass through
        $target.unbind type, handler
        
        # Close dialog
        $(dialog).dialog "close"
        
        # Check if there is any events on the target
        if jQuery.data(target, "events")
          
          # Trigger click event.
          $target.click()
        else
          
          # No event trigger new url
          urlClick()
        init()

      buttons[locale.button[0]] = ->
        $(dialog).dialog "close"

      $(dialog).dialog
        autoOpen: false
        resizable: false
        draggable: true
        closeOnEscape: true
        width: "auto"
        minHeight: 120
        maxHeight: 200
        buttons: buttons
        title: locale.title
        closeText: locale.closeText
        modal: true

      
      # Handler that will override all other actions
      handler = (event) ->
        $(dialog).dialog "open"
        event.stopImmediatePropagation()
        event.preventDefault()
        false

      init = ->
        saveHandlers()
        $target.bind type, handler
        rebindHandlers()

      init()

) jQuery