
/*
jQuery Easy Confirm Dialog plugin 1.2

Copyright (c) 2010 Emil Janitzek (http://projectshadowlight.org)
Based on Confirm 1.3 by Nadia Alramli (http://nadiana.com/)

Samples and instructions at:
http://projectshadowlight.org/jquery-easy-confirm-dialog/

This script is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option)
any later version.
*/


(function() {

  (function($) {
    $.easyconfirm = {};
    $.easyconfirm.locales = {};
    $.easyconfirm.locales.enUS = {
      title: "Are you sure?",
      text: "Are you sure that you want to perform this action?",
      button: ["Cancel", "Confirm"],
      closeText: "close"
    };
    $.easyconfirm.locales.svSE = {
      title: "Är du säker?",
      text: "Är du säker på att du vill genomföra denna åtgärden?",
      button: ["Avbryt", "Bekräfta"],
      closeText: "stäng"
    };
    $.easyconfirm.locales.itIT = {
      title: "Sei sicuro?",
      text: "Sei sicuro di voler compiere questa azione?",
      button: ["Annulla", "Conferma"],
      closeText: "chiudi"
    };
    return $.fn.easyconfirm = function(options) {
      var locale, type, _attr;
      _attr = $.fn.attr;
      $.fn.attr = function(attr, value) {
        var returned;
        returned = _attr.apply(this, arguments_);
        if (attr === "title" && returned === undefined) {
          returned = "";
        }
        return returned;
      };
      options = jQuery.extend({
        eventType: "click",
        icon: "help"
      }, options);
      locale = jQuery.extend({}, $.easyconfirm.locales.enUS, options.locale);
      type = options.eventType;
      return this.each(function() {
        var $target, buttons, dialog, handler, init, rebindHandlers, saveHandlers, target, urlClick;
        target = this;
        $target = jQuery(target);
        urlClick = function() {
          var length;
          if (target.href) {
            length = String(target.href).length;
            if (target.href.substring(length - 1, length) !== "#") {
              return document.location = target.href;
            }
          }
        };
        saveHandlers = function() {
          var events;
          events = jQuery.data(target, "events");
          if (events) {
            target._handlers = new Array();
            $.each(events[type], function() {
              return target._handlers.push(this);
            });
            return $target.unbind(type);
          }
        };
        rebindHandlers = function() {
          if (target._handlers !== undefined) {
            return jQuery.each(target._handlers, function() {
              return $target.bind(type, this);
            });
          }
        };
        if ($target.attr("title") !== null && $target.attr("title").length > 0) {
          locale.text = $target.attr("title");
        }
        dialog = (options.dialog === undefined || typeof options.dialog !== "object" ? $("<div class=\"dialog confirm\">" + locale.text + "</div>") : options.dialog);
        buttons = {};
        buttons[locale.button[1]] = function() {
          $target.unbind(type, handler);
          $(dialog).dialog("close");
          if (jQuery.data(target, "events")) {
            $target.click();
          } else {
            urlClick();
          }
          return init();
        };
        buttons[locale.button[0]] = function() {
          return $(dialog).dialog("close");
        };
        $(dialog).dialog({
          autoOpen: false,
          resizable: false,
          draggable: true,
          closeOnEscape: true,
          width: "auto",
          minHeight: 120,
          maxHeight: 200,
          buttons: buttons,
          title: locale.title,
          closeText: locale.closeText,
          modal: true
        });
        handler = function(event) {
          $(dialog).dialog("open");
          event.stopImmediatePropagation();
          event.preventDefault();
          return false;
        };
        init = function() {
          saveHandlers();
          $target.bind(type, handler);
          return rebindHandlers();
        };
        return init();
      });
    };
  })(jQuery);

}).call(this);
