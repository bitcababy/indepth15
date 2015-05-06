# ###
# PeriodicalUpdater - jQuery plugin for timed, decaying ajax calls
#
# http://www.360innovate.co.uk
#
# Copyright (c) 2009 360innovate (http://www.360innovate.co.uk)
# Dual licensed under the MIT and GPL licenses:
# http://www.opensource.org/licenses/mit-license.php
# http://www.gnu.org/licenses/gpl.html
#
# Version: 1.0
# ###
# (($) ->
#   $.fn.periodicalUpdater = (options, callback) ->
#     getdata = ->
#       f settings.url, settings.sendData, ((d) ->
#         if prevContent isnt d
#
#           # content has changed
#           prevContent = d
#           callback d if callback
#
#           # recursive call to getdata(). You can stop ajax requests from this plugin by calling clearTimeout(PeriodicalTimer);
#           # (on a button click, for example)
#           PeriodicalTimer = setTimeout(getdata, settings.minTimeout)
#         else
#           # content hasn't changed - re-calculate timers and recursively call getdata() again
#           timerInterval = timerInterval * settings.multiplier  if timerInterval < settings.maxTimeout
#           timerInterval = settings.maxTimeout  if timerInterval > settings.maxTimeout
#           PeriodicalTimer = setTimeout(getdata, timerInterval)
#       ), settings.type
#
#     settings = $.extend(
#       url: ""							# URL of ajax request
#       method: "get"				# method; get or post
#       sendData: ""				# array of values to be passed to the page - e.g. {name: "John", greeting: "hello"}
#       minTimeout: 1000		# starting value for the timeout in milliseconds
#       maxTimeout: 8000		# maximum length of time between requests
#       multiplier: 2				# if set to 2, timerInterval will double each time the response hasn't changed (up to maxTimeout)
#       type: "text"				# response type - text, xml, json etc - as with $.get or $.post
#     , options)
#
#     # should we be GETting or POSTing the URL?
#     f = (if settings.method is "post" or settings.method is "POST" then $.post else $.get)
#
#     # you really, really don't want multipliers of less than 1 - it will cause lots of strain on the server!
#     settings.multiplier = (if settings.multiplier < 1 then 1 else settings.multiplier)
#
#     # set some initial values, then begin
#     prevContent = undefined
#     timerInterval = settings.minTimeout
#     getdata()
# ) jQuery
