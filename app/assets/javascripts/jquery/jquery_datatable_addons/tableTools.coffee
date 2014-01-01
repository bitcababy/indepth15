# #
# # * File:        TableTools.js
# # * Version:     2.1.3
# # * Description: Tools and buttons for DataTables
# # * Author:      Allan Jardine (www.sprymedia.co.uk)
# # * Language:    Javascript
# # * License:        GPL v2 or BSD 3 point style
# # * Project:	    DataTables
# # * 
# # * Copyright 2009-2012 Allan Jardine, all rights reserved.
# # *
# # * This source file is free software, under either the GPL v2 license or a
# # * BSD style license, available at:
# # *   http://datatables.net/license_gpl2
# # *   http://datatables.net/license_bsd
# # 
# 
# # Global scope for TableTools 
# TableTools = undefined
# (($, window, document) ->
#   
#   ###
#   TableTools provides flexible buttons and other tools for a DataTables enhanced table
#   @class TableTools
#   @constructor
#   @param {Object} oDT DataTables instance
#   @param {Object} oOpts TableTools options
#   @param {String} oOpts.sSwfPath ZeroClipboard SWF path
#   @param {String} oOpts.sRowSelect Row selection options - 'none', 'single' or 'multi'
#   @param {Function} oOpts.fnPreRowSelect Callback function just prior to row selection
#   @param {Function} oOpts.fnRowSelected Callback function just after row selection
#   @param {Function} oOpts.fnRowDeselected Callback function when row is deselected
#   @param {Array} oOpts.aButtons List of buttons to be used
#   ###
#   TableTools = (oDT, oOpts) ->
#     
#     # Santiy check that we are a new instance 
#     alert "Warning: TableTools must be initialised with the keyword 'new'"  if not this instanceof TableTools
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Public class variables
#     #	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#     
#     ###
#     @namespace Settings object which contains customisable information for TableTools instance
#     ###
#     @s =
#       
#       ###
#       Store 'this' so the instance can be retrieved from the settings object
#       @property that
#       @type	 object
#       @default  this
#       ###
#       that: this
#       
#       ###
#       DataTables settings objects
#       @property dt
#       @type	 object
#       @default  <i>From the oDT init option</i>
#       ###
#       dt: oDT.fnSettings()
#       
#       ###
#       @namespace Print specific information
#       ###
#       print:
#         
#         ###
#         DataTables draw 'start' point before the printing display was shown
#         @property saveStart
#         @type	 int
#         @default  -1
#         ###
#         saveStart: -1
#         
#         ###
#         DataTables draw 'length' point before the printing display was shown
#         @property saveLength
#         @type	 int
#         @default  -1
#         ###
#         saveLength: -1
#         
#         ###
#         Page scrolling point before the printing display was shown so it can be restored
#         @property saveScroll
#         @type	 int
#         @default  -1
#         ###
#         saveScroll: -1
#         
#         ###
#         Wrapped function to end the print display (to maintain scope)
#         @property funcEnd
#         @type	 Function
#         @default  function () {}
#         ###
#         funcEnd: ->
# 
#       
#       ###
#       A unique ID is assigned to each button in each instance
#       @property buttonCounter
#       @type	 int
#       @default  0
#       ###
#       buttonCounter: 0
#       
#       ###
#       @namespace Select rows specific information
#       ###
#       select:
#         
#         ###
#         Select type - can be 'none', 'single' or 'multi'
#         @property type
#         @type	 string
#         @default  ""
#         ###
#         type: ""
#         
#         ###
#         Array of nodes which are currently selected
#         @property selected
#         @type	 array
#         @default  []
#         ###
#         selected: []
#         
#         ###
#         Function to run before the selection can take place. Will cancel the select if the
#         function returns false
#         @property preRowSelect
#         @type	 Function
#         @default  null
#         ###
#         preRowSelect: null
#         
#         ###
#         Function to run when a row is selected
#         @property postSelected
#         @type	 Function
#         @default  null
#         ###
#         postSelected: null
#         
#         ###
#         Function to run when a row is deselected
#         @property postDeselected
#         @type	 Function
#         @default  null
#         ###
#         postDeselected: null
#         
#         ###
#         Indicate if all rows are selected (needed for server-side processing)
#         @property all
#         @type	 boolean
#         @default  false
#         ###
#         all: false
#         
#         ###
#         Class name to add to selected TR nodes
#         @property selectedClass
#         @type	 String
#         @default  ""
#         ###
#         selectedClass: ""
# 
#       
#       ###
#       Store of the user input customisation object
#       @property custom
#       @type	 object
#       @default  {}
#       ###
#       custom: {}
#       
#       ###
#       SWF movie path
#       @property swfPath
#       @type	 string
#       @default  ""
#       ###
#       swfPath: ""
#       
#       ###
#       Default button set
#       @property buttonSet
#       @type	 array
#       @default  []
#       ###
#       buttonSet: []
#       
#       ###
#       When there is more than one TableTools instance for a DataTable, there must be a
#       master which controls events (row selection etc)
#       @property master
#       @type	 boolean
#       @default  false
#       ###
#       master: false
#       
#       ###
#       Tag names that are used for creating collections and buttons
#       @namesapce
#       ###
#       tags: {}
# 
#     
#     ###
#     @namespace Common and useful DOM elements for the class instance
#     ###
#     @dom =
#       
#       ###
#       DIV element that is create and all TableTools buttons (and their children) put into
#       @property container
#       @type	 node
#       @default  null
#       ###
#       container: null
#       
#       ###
#       The table node to which TableTools will be applied
#       @property table
#       @type	 node
#       @default  null
#       ###
#       table: null
#       
#       ###
#       @namespace Nodes used for the print display
#       ###
#       print:
#         
#         ###
#         Nodes which have been removed from the display by setting them to display none
#         @property hidden
#         @type	 array
#         @default  []
#         ###
#         hidden: []
#         
#         ###
#         The information display saying telling the user about the print display
#         @property message
#         @type	 node
#         @default  null
#         ###
#         message: null
# 
#       
#       ###
#       @namespace Nodes used for a collection display. This contains the currently used collection
#       ###
#       collection:
#         
#         ###
#         The div wrapper containing the buttons in the collection (i.e. the menu)
#         @property collection
#         @type	 node
#         @default  null
#         ###
#         collection: null
#         
#         ###
#         Background display to provide focus and capture events
#         @property background
#         @type	 node
#         @default  null
#         ###
#         background: null
# 
#     
#     ###
#     @namespace Name space for the classes that this TableTools instance will use
#     @extends TableTools.classes
#     ###
#     @classes = $.extend(true, {}, TableTools.classes)
#     $.extend true, @classes, TableTools.classes_themeroller  if @s.dt.bJUI
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Public class methods
#     #	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#     
#     ###
#     Retreieve the settings object from an instance
#     @method fnSettings
#     @returns {object} TableTools settings object
#     ###
#     @fnSettings = ->
#       @s
# 
#     
#     # Constructor logic 
#     oOpts = {}  if typeof oOpts is "undefined"
#     @_fnConstruct oOpts
#     this
# 
#   TableTools:: =
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Public methods
#     #	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#     
#     ###
#     Retreieve the settings object from an instance
#     @returns {array} List of TR nodes which are currently selected
#     ###
#     fnGetSelected: ->
#       out = []
#       data = @s.dt.aoData
#       i = undefined
#       iLen = undefined
#       i = 0
#       iLen = data.length
# 
#       while i < iLen
#         out.push data[i].nTr  if data[i]._DTTT_selected
#         i++
#       out
# 
#     
#     ###
#     Get the data source objects/arrays from DataTables for the selected rows (same as
#     fnGetSelected followed by fnGetData on each row from the table)
#     @returns {array} Data from the TR nodes which are currently selected
#     ###
#     fnGetSelectedData: ->
#       out = []
#       data = @s.dt.aoData
#       i = undefined
#       iLen = undefined
#       i = 0
#       iLen = data.length
# 
#       while i < iLen
#         out.push @s.dt.oInstance.fnGetData(i)  if data[i]._DTTT_selected
#         i++
#       out
# 
#     
#     ###
#     Check to see if a current row is selected or not
#     @param {Node} n TR node to check if it is currently selected or not
#     @returns {Boolean} true if select, false otherwise
#     ###
#     fnIsSelected: (n) ->
#       pos = @s.dt.oInstance.fnGetPosition(n)
#       (if (@s.dt.aoData[pos]._DTTT_selected is true) then true else false)
# 
#     
#     ###
#     Select all rows in the table
#     @param {boolean} [filtered=false] Select only rows which are available
#     given the filtering applied to the table. By default this is false -
#     i.e. all rows, regardless of filtering are selected.
#     ###
#     fnSelectAll: (filtered) ->
#       s = @_fnGetMasterSettings()
#       @_fnRowSelect (if (filtered is true) then s.dt.aiDisplay else s.dt.aoData)
# 
#     
#     ###
#     Deselect all rows in the table
#     @param {boolean} [filtered=false] Deselect only rows which are available
#     given the filtering applied to the table. By default this is false -
#     i.e. all rows, regardless of filtering are deselected.
#     ###
#     fnSelectNone: (filtered) ->
#       s = @_fnGetMasterSettings()
#       @_fnRowDeselect (if (filtered is true) then s.dt.aiDisplay else s.dt.aoData)
# 
#     
#     ###
#     Select row(s)
#     @param {node|object|array} n The row(s) to select. Can be a single DOM
#     TR node, an array of TR nodes or a jQuery object.
#     ###
#     fnSelect: (n) ->
#       if @s.select.type is "single"
#         @fnSelectNone()
#         @_fnRowSelect n
#       else @_fnRowSelect n  if @s.select.type is "multi"
# 
#     
#     ###
#     Deselect row(s)
#     @param {node|object|array} n The row(s) to deselect. Can be a single DOM
#     TR node, an array of TR nodes or a jQuery object.
#     ###
#     fnDeselect: (n) ->
#       @_fnRowDeselect n
# 
#     
#     ###
#     Get the title of the document - useful for file names. The title is retrieved from either
#     the configuration object's 'title' parameter, or the HTML document title
#     @param   {Object} oConfig Button configuration object
#     @returns {String} Button title
#     ###
#     fnGetTitle: (oConfig) ->
#       sTitle = ""
#       if typeof oConfig.sTitle isnt "undefined" and oConfig.sTitle isnt ""
#         sTitle = oConfig.sTitle
#       else
#         anTitle = document.getElementsByTagName("title")
#         sTitle = anTitle[0].innerHTML  if anTitle.length > 0
#       
#       # Strip characters which the OS will object to - checking for UTF8 support in the scripting
#       #		 * engine
#       #		 
#       if "¡".toString().length < 4
#         sTitle.replace /[^a-zA-Z0-9_\u00A1-\uFFFF\.,\-_ !\(\)]/g, ""
#       else
#         sTitle.replace /[^a-zA-Z0-9_\.,\-_ !\(\)]/g, ""
# 
#     
#     ###
#     Calculate a unity array with the column width by proportion for a set of columns to be
#     included for a button. This is particularly useful for PDF creation, where we can use the
#     column widths calculated by the browser to size the columns in the PDF.
#     @param   {Object} oConfig Button configuration object
#     @returns {Array} Unity array of column ratios
#     ###
#     fnCalcColRatios: (oConfig) ->
#       aoCols = @s.dt.aoColumns
#       aColumnsInc = @_fnColumnTargets(oConfig.mColumns)
#       aColWidths = []
#       iWidth = 0
#       iTotal = 0
#       i = undefined
#       iLen = undefined
#       i = 0
#       iLen = aColumnsInc.length
# 
#       while i < iLen
#         if aColumnsInc[i]
#           iWidth = aoCols[i].nTh.offsetWidth
#           iTotal += iWidth
#           aColWidths.push iWidth
#         i++
#       i = 0
#       iLen = aColWidths.length
# 
#       while i < iLen
#         aColWidths[i] = aColWidths[i] / iTotal
#         i++
#       aColWidths.join "\t"
# 
#     
#     ###
#     Get the information contained in a table as a string
#     @param   {Object} oConfig Button configuration object
#     @returns {String} Table data as a string
#     ###
#     fnGetTableData: (oConfig) ->
#       
#       # In future this could be used to get data from a plain HTML source as well as DataTables 
#       @_fnGetDataTablesData oConfig  if @s.dt
# 
#     
#     ###
#     Pass text to a flash button instance, which will be used on the button's click handler
#     @param   {Object} clip Flash button object
#     @param   {String} text Text to set
#     ###
#     fnSetText: (clip, text) ->
#       @_fnFlashSetText clip, text
# 
#     
#     ###
#     Resize the flash elements of the buttons attached to this TableTools instance - this is
#     useful for when initialising TableTools when it is hidden (display:none) since sizes can't
#     be calculated at that time.
#     ###
#     fnResizeButtons: ->
#       for cli of ZeroClipboard_TableTools.clients
#         if cli
#           client = ZeroClipboard_TableTools.clients[cli]
#           client.positionElement()  if typeof client.domElement isnt "undefined" and client.domElement.parentNode
# 
#     
#     ###
#     Check to see if any of the ZeroClipboard client's attached need to be resized
#     ###
#     fnResizeRequired: ->
#       for cli of ZeroClipboard_TableTools.clients
#         if cli
#           client = ZeroClipboard_TableTools.clients[cli]
#           return true  if typeof client.domElement isnt "undefined" and client.domElement.parentNode is @dom.container and client.sized is false
#       false
# 
#     
#     ###
#     Programmatically enable or disable the print view
#     @param {boolean} [bView=true] Show the print view if true or not given. If false, then
#     terminate the print view and return to normal.
#     @param {object} [oConfig={}] Configuration for the print view
#     @param {boolean} [oConfig.bShowAll=false] Show all rows in the table if true
#     @param {string} [oConfig.sInfo] Information message, displayed as an overlay to the
#     user to let them know what the print view is.
#     @param {string} [oConfig.sMessage] HTML string to show at the top of the document - will
#     be included in the printed document.
#     ###
#     fnPrint: (bView, oConfig) ->
#       oConfig = {}  if oConfig is `undefined`
#       if bView is `undefined` or bView
#         @_fnPrintStart oConfig
#       else
#         @_fnPrintEnd()
# 
#     
#     ###
#     Show a message to the end user which is nicely styled
#     @param {string} message The HTML string to show to the user
#     @param {int} time The duration the message is to be shown on screen for (mS)
#     ###
#     fnInfo: (message, time) ->
#       nInfo = document.createElement("div")
#       nInfo.className = @classes.print.info
#       nInfo.innerHTML = message
#       document.body.appendChild nInfo
#       setTimeout (->
#         $(nInfo).fadeOut "normal", ->
#           document.body.removeChild nInfo
# 
#       ), time
# 
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Private methods (they are of course public in JS, but recommended as private)
#     #	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#     
#     ###
#     Constructor logic
#     @method  _fnConstruct
#     @param   {Object} oOpts Same as TableTools constructor
#     @returns void
#     @private
#     ###
#     _fnConstruct: (oOpts) ->
#       that = this
#       @_fnCustomiseSettings oOpts
#       
#       # Container element 
#       @dom.container = document.createElement(@s.tags.container)
#       @dom.container.className = @classes.container
#       
#       # Row selection config 
#       @_fnRowSelectConfig()  unless @s.select.type is "none"
#       
#       # Buttons 
#       @_fnButtonDefinations @s.buttonSet, @dom.container
#       
#       # Destructor - need to wipe the DOM for IE's garbage collector 
#       @s.dt.aoDestroyCallback.push
#         sName: "TableTools"
#         fn: ->
#           that.dom.container.innerHTML = ""
# 
# 
#     
#     ###
#     Take the user defined settings and the default settings and combine them.
#     @method  _fnCustomiseSettings
#     @param   {Object} oOpts Same as TableTools constructor
#     @returns void
#     @private
#     ###
#     _fnCustomiseSettings: (oOpts) ->
#       
#       # Is this the master control instance or not? 
#       if typeof @s.dt._TableToolsInit is "undefined"
#         @s.master = true
#         @s.dt._TableToolsInit = true
#       
#       # We can use the table node from comparisons to group controls 
#       @dom.table = @s.dt.nTable
#       
#       # Clone the defaults and then the user options 
#       @s.custom = $.extend({}, TableTools.DEFAULTS, oOpts)
#       
#       # Flash file location 
#       @s.swfPath = @s.custom.sSwfPath
#       ZeroClipboard_TableTools.moviePath = @s.swfPath  unless typeof ZeroClipboard_TableTools is "undefined"
#       
#       # Table row selecting 
#       @s.select.type = @s.custom.sRowSelect
#       @s.select.preRowSelect = @s.custom.fnPreRowSelect
#       @s.select.postSelected = @s.custom.fnRowSelected
#       @s.select.postDeselected = @s.custom.fnRowDeselected
#       
#       # Backwards compatibility - allow the user to specify a custom class in the initialiser
#       @classes.select.row = @s.custom.sSelectedClass  if @s.custom.sSelectedClass
#       @s.tags = @s.custom.oTags
#       
#       # Button set 
#       @s.buttonSet = @s.custom.aButtons
# 
#     
#     ###
#     Take the user input arrays and expand them to be fully defined, and then add them to a given
#     DOM element
#     @method  _fnButtonDefinations
#     @param {array} buttonSet Set of user defined buttons
#     @param {node} wrapper Node to add the created buttons to
#     @returns void
#     @private
#     ###
#     _fnButtonDefinations: (buttonSet, wrapper) ->
#       buttonDef = undefined
#       i = 0
#       iLen = buttonSet.length
# 
#       while i < iLen
#         if typeof buttonSet[i] is "string"
#           if typeof TableTools.BUTTONS[buttonSet[i]] is "undefined"
#             alert "TableTools: Warning - unknown button type: " + buttonSet[i]
#             continue
#           buttonDef = $.extend({}, TableTools.BUTTONS[buttonSet[i]], true)
#         else
#           if typeof TableTools.BUTTONS[buttonSet[i].sExtends] is "undefined"
#             alert "TableTools: Warning - unknown button type: " + buttonSet[i].sExtends
#             continue
#           o = $.extend({}, TableTools.BUTTONS[buttonSet[i].sExtends], true)
#           buttonDef = $.extend(o, buttonSet[i], true)
#         wrapper.appendChild @_fnCreateButton(buttonDef, $(wrapper).hasClass(@classes.collection.container))
#         i++
# 
#     
#     ###
#     Create and configure a TableTools button
#     @method  _fnCreateButton
#     @param   {Object} oConfig Button configuration object
#     @returns {Node} Button element
#     @private
#     ###
#     _fnCreateButton: (oConfig, bCollectionButton) ->
#       nButton = @_fnButtonBase(oConfig, bCollectionButton)
#       if oConfig.sAction.match(/flash/)
#         @_fnFlashConfig nButton, oConfig
#       else if oConfig.sAction is "text"
#         @_fnTextConfig nButton, oConfig
#       else if oConfig.sAction is "div"
#         @_fnTextConfig nButton, oConfig
#       else if oConfig.sAction is "collection"
#         @_fnTextConfig nButton, oConfig
#         @_fnCollectionConfig nButton, oConfig
#       nButton
# 
#     
#     ###
#     Create the DOM needed for the button and apply some base properties. All buttons start here
#     @method  _fnButtonBase
#     @param   {o} oConfig Button configuration object
#     @returns {Node} DIV element for the button
#     @private
#     ###
#     _fnButtonBase: (o, bCollectionButton) ->
#       sTag = undefined
#       sLiner = undefined
#       sClass = undefined
#       if bCollectionButton
#         sTag = (if o.sTag isnt "default" then o.sTag else @s.tags.collection.button)
#         sLiner = (if o.sLinerTag isnt "default" then o.sLiner else @s.tags.collection.liner)
#         sClass = @classes.collection.buttons.normal
#       else
#         sTag = (if o.sTag isnt "default" then o.sTag else @s.tags.button)
#         sLiner = (if o.sLinerTag isnt "default" then o.sLiner else @s.tags.liner)
#         sClass = @classes.buttons.normal
#       nButton = document.createElement(sTag)
#       nSpan = document.createElement(sLiner)
#       masterS = @_fnGetMasterSettings()
#       nButton.className = sClass + " " + o.sButtonClass
#       nButton.setAttribute "id", "ToolTables_" + @s.dt.sInstance + "_" + masterS.buttonCounter
#       nButton.appendChild nSpan
#       nSpan.innerHTML = o.sButtonText
#       masterS.buttonCounter++
#       nButton
# 
#     
#     ###
#     Get the settings object for the master instance. When more than one TableTools instance is
#     assigned to a DataTable, only one of them can be the 'master' (for the select rows). As such,
#     we will typically want to interact with that master for global properties.
#     @method  _fnGetMasterSettings
#     @returns {Object} TableTools settings object
#     @private
#     ###
#     _fnGetMasterSettings: ->
#       if @s.master
#         @s
#       else
#         
#         # Look for the master which has the same DT as this one 
#         instances = TableTools._aInstances
#         i = 0
#         iLen = instances.length
# 
#         while i < iLen
#           return instances[i].s  if @dom.table is instances[i].s.dt.nTable
#           i++
# 
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Button collection functions
#     #	 
#     
#     ###
#     Create a collection button, when activated will present a drop down list of other buttons
#     @param   {Node} nButton Button to use for the collection activation
#     @param   {Object} oConfig Button configuration object
#     @returns void
#     @private
#     ###
#     _fnCollectionConfig: (nButton, oConfig) ->
#       nHidden = document.createElement(@s.tags.collection.container)
#       nHidden.style.display = "none"
#       nHidden.className = @classes.collection.container
#       oConfig._collection = nHidden
#       document.body.appendChild nHidden
#       @_fnButtonDefinations oConfig.aButtons, nHidden
# 
#     
#     ###
#     Show a button collection
#     @param   {Node} nButton Button to use for the collection
#     @param   {Object} oConfig Button configuration object
#     @returns void
#     @private
#     ###
#     _fnCollectionShow: (nButton, oConfig) ->
#       that = this
#       oPos = $(nButton).offset()
#       nHidden = oConfig._collection
#       iDivX = oPos.left
#       iDivY = oPos.top + $(nButton).outerHeight()
#       iWinHeight = $(window).height()
#       iDocHeight = $(document).height()
#       iWinWidth = $(window).width()
#       iDocWidth = $(document).width()
#       nHidden.style.position = "absolute"
#       nHidden.style.left = iDivX + "px"
#       nHidden.style.top = iDivY + "px"
#       nHidden.style.display = "block"
#       $(nHidden).css "opacity", 0
#       nBackground = document.createElement("div")
#       nBackground.style.position = "absolute"
#       nBackground.style.left = "0px"
#       nBackground.style.top = "0px"
#       nBackground.style.height = ((if (iWinHeight > iDocHeight) then iWinHeight else iDocHeight)) + "px"
#       nBackground.style.width = ((if (iWinWidth > iDocWidth) then iWinWidth else iDocWidth)) + "px"
#       nBackground.className = @classes.collection.background
#       $(nBackground).css "opacity", 0
#       document.body.appendChild nBackground
#       document.body.appendChild nHidden
#       
#       # Visual corrections to try and keep the collection visible 
#       iDivWidth = $(nHidden).outerWidth()
#       iDivHeight = $(nHidden).outerHeight()
#       nHidden.style.left = (iDocWidth - iDivWidth) + "px"  if iDivX + iDivWidth > iDocWidth
#       nHidden.style.top = (iDivY - iDivHeight - $(nButton).outerHeight()) + "px"  if iDivY + iDivHeight > iDocHeight
#       @dom.collection.collection = nHidden
#       @dom.collection.background = nBackground
#       
#       # This results in a very small delay for the end user but it allows the animation to be
#       #		 * much smoother. If you don't want the animation, then the setTimeout can be removed
#       #		 
#       setTimeout (->
#         $(nHidden).animate
#           opacity: 1
#         , 500
#         $(nBackground).animate
#           opacity: 0.25
#         , 500
#       ), 10
#       
#       # Resize the buttons to the Flash contents fit 
#       @fnResizeButtons()
#       
#       # Event handler to remove the collection display 
#       $(nBackground).click ->
#         that._fnCollectionHide.call that, null, null
# 
# 
#     
#     ###
#     Hide a button collection
#     @param   {Node} nButton Button to use for the collection
#     @param   {Object} oConfig Button configuration object
#     @returns void
#     @private
#     ###
#     _fnCollectionHide: (nButton, oConfig) ->
#       return  if oConfig isnt null and oConfig.sExtends is "collection"
#       if @dom.collection.collection isnt null
#         $(@dom.collection.collection).animate
#           opacity: 0
#         , 500, (e) ->
#           @style.display = "none"
# 
#         $(@dom.collection.background).animate
#           opacity: 0
#         , 500, (e) ->
#           @parentNode.removeChild this
# 
#         @dom.collection.collection = null
#         @dom.collection.background = null
# 
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Row selection functions
#     #	 
#     
#     ###
#     Add event handlers to a table to allow for row selection
#     @method  _fnRowSelectConfig
#     @returns void
#     @private
#     ###
#     _fnRowSelectConfig: ->
#       if @s.master
#         that = this
#         i = undefined
#         iLen = undefined
#         dt = @s.dt
#         aoOpenRows = @s.dt.aoOpenRows
#         $(dt.nTable).addClass @classes.select.table
#         $("tr", dt.nTBody).live "click", (e) ->
#           
#           # Sub-table must be ignored (odd that the selector won't do this with >) 
#           return  unless @parentNode is dt.nTBody
#           
#           # Check that we are actually working with a DataTables controlled row 
#           return  if dt.oInstance.fnGetData(this) is null
#           
#           # User defined selection function 
#           return  if that.s.select.preRowSelect isnt null and not that.s.select.preRowSelect.call(that, e)
#           if that.fnIsSelected(this)
#             that._fnRowDeselect this
#           else if that.s.select.type is "single"
#             that.fnSelectNone()
#             that._fnRowSelect this
#           else that._fnRowSelect this  if that.s.select.type is "multi"
# 
#         
#         # Bind a listener to the DataTable for when new rows are created.
#         # This allows rows to be visually selected when they should be and
#         # deferred rendering is used.
#         dt.oApi._fnCallbackReg dt, "aoRowCreatedCallback", ((tr, data, index) ->
#           $(tr).addClass that.classes.select.row  if dt.aoData[index]._DTTT_selected
#         ), "TableTools-SelectAll"
# 
#     
#     ###
#     Select rows
#     @param   {*} src Rows to select - see _fnSelectData for a description of valid inputs
#     @private
#     ###
#     _fnRowSelect: (src) ->
#       data = @_fnSelectData(src)
#       firstTr = (if data.length is 0 then null else data[0].nTr)
#       i = 0
#       iLen = data.length
# 
#       while i < iLen
#         data[i]._DTTT_selected = true
#         $(data[i].nTr).addClass @classes.select.row  if data[i].nTr
#         i++
#       @s.select.postSelected.call this, firstTr  if @s.select.postSelected isnt null
#       TableTools._fnEventDispatch this, "select", firstTr
# 
#     
#     ###
#     Deselect rows
#     @param   {*} src Rows to deselect - see _fnSelectData for a description of valid inputs
#     @private
#     ###
#     _fnRowDeselect: (src) ->
#       data = @_fnSelectData(src)
#       firstTr = (if data.length is 0 then null else data[0].nTr)
#       i = 0
#       iLen = data.length
# 
#       while i < iLen
#         $(data[i].nTr).removeClass @classes.select.row  if data[i].nTr and data[i]._DTTT_selected
#         data[i]._DTTT_selected = false
#         i++
#       @s.select.postDeselected.call this, firstTr  if @s.select.postDeselected isnt null
#       TableTools._fnEventDispatch this, "select", firstTr
# 
#     
#     ###
#     Take a data source for row selection and convert it into aoData points for the DT
#     @param {*} src Can be a single DOM TR node, an array of TR nodes (including a
#     a jQuery object), a single aoData point from DataTables, an array of aoData
#     points or an array of aoData indexes
#     @returns {array} An array of aoData points
#     ###
#     _fnSelectData: (src) ->
#       out = []
#       pos = undefined
#       i = undefined
#       iLen = undefined
#       if src.nodeName
#         
#         # Single node
#         pos = @s.dt.oInstance.fnGetPosition(src)
#         out.push @s.dt.aoData[pos]
#       else if typeof src.length isnt "undefined"
#         
#         # jQuery object or an array of nodes, or aoData points
#         i = 0
#         iLen = src.length
# 
#         while i < iLen
#           if src[i].nodeName
#             pos = @s.dt.oInstance.fnGetPosition(src[i])
#             out.push @s.dt.aoData[pos]
#           else if typeof src[i] is "number"
#             out.push @s.dt.aoData[src[i]]
#           else
#             out.push src[i]
#           i++
#         return out
#       else
#         
#         # A single aoData point
#         out.push src
#       out
# 
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Text button functions
#     #	 
#     
#     ###
#     Configure a text based button for interaction events
#     @method  _fnTextConfig
#     @param   {Node} nButton Button element which is being considered
#     @param   {Object} oConfig Button configuration object
#     @returns void
#     @private
#     ###
#     _fnTextConfig: (nButton, oConfig) ->
#       that = this
#       oConfig.fnInit.call this, nButton, oConfig  if oConfig.fnInit isnt null
#       nButton.title = oConfig.sToolTip  if oConfig.sToolTip isnt ""
#       $(nButton).hover (->
#         oConfig.fnMouseover.call this, nButton, oConfig, null  if oConfig.fnMouseover isnt null
#       ), ->
#         oConfig.fnMouseout.call this, nButton, oConfig, null  if oConfig.fnMouseout isnt null
# 
#       if oConfig.fnSelect isnt null
#         TableTools._fnEventListen this, "select", (n) ->
#           oConfig.fnSelect.call that, nButton, oConfig, n
# 
#       $(nButton).click (e) ->
#         
#         #e.preventDefault();
#         oConfig.fnClick.call that, nButton, oConfig, null  if oConfig.fnClick isnt null
#         
#         # Provide a complete function to match the behaviour of the flash elements 
#         oConfig.fnComplete.call that, nButton, oConfig, null, null  if oConfig.fnComplete isnt null
#         that._fnCollectionHide nButton, oConfig
# 
# 
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Flash button functions
#     #	 
#     
#     ###
#     Configure a flash based button for interaction events
#     @method  _fnFlashConfig
#     @param   {Node} nButton Button element which is being considered
#     @param   {o} oConfig Button configuration object
#     @returns void
#     @private
#     ###
#     _fnFlashConfig: (nButton, oConfig) ->
#       that = this
#       flash = new ZeroClipboard_TableTools.Client()
#       oConfig.fnInit.call this, nButton, oConfig  if oConfig.fnInit isnt null
#       flash.setHandCursor true
#       if oConfig.sAction is "flash_save"
#         flash.setAction "save"
#         flash.setCharSet (if (oConfig.sCharSet is "utf16le") then "UTF16LE" else "UTF8")
#         flash.setBomInc oConfig.bBomInc
#         flash.setFileName oConfig.sFileName.replace("*", @fnGetTitle(oConfig))
#       else if oConfig.sAction is "flash_pdf"
#         flash.setAction "pdf"
#         flash.setFileName oConfig.sFileName.replace("*", @fnGetTitle(oConfig))
#       else
#         flash.setAction "copy"
#       flash.addEventListener "mouseOver", (client) ->
#         oConfig.fnMouseover.call that, nButton, oConfig, flash  if oConfig.fnMouseover isnt null
# 
#       flash.addEventListener "mouseOut", (client) ->
#         oConfig.fnMouseout.call that, nButton, oConfig, flash  if oConfig.fnMouseout isnt null
# 
#       flash.addEventListener "mouseDown", (client) ->
#         oConfig.fnClick.call that, nButton, oConfig, flash  if oConfig.fnClick isnt null
# 
#       flash.addEventListener "complete", (client, text) ->
#         oConfig.fnComplete.call that, nButton, oConfig, flash, text  if oConfig.fnComplete isnt null
#         that._fnCollectionHide nButton, oConfig
# 
#       @_fnFlashGlue flash, nButton, oConfig.sToolTip
# 
#     
#     ###
#     Wait until the id is in the DOM before we "glue" the swf. Note that this function will call
#     itself (using setTimeout) until it completes successfully
#     @method  _fnFlashGlue
#     @param   {Object} clip Zero clipboard object
#     @param   {Node} node node to glue swf to
#     @param   {String} text title of the flash movie
#     @returns void
#     @private
#     ###
#     _fnFlashGlue: (flash, node, text) ->
#       that = this
#       id = node.getAttribute("id")
#       if document.getElementById(id)
#         flash.glue node, text
#       else
#         setTimeout (->
#           that._fnFlashGlue flash, node, text
#         ), 100
# 
#     
#     ###
#     Set the text for the flash clip to deal with
#     
#     This function is required for large information sets. There is a limit on the
#     amount of data that can be transferred between Javascript and Flash in a single call, so
#     we use this method to build up the text in Flash by sending over chunks. It is estimated
#     that the data limit is around 64k, although it is undocumented, and appears to be different
#     between different flash versions. We chunk at 8KiB.
#     @method  _fnFlashSetText
#     @param   {Object} clip the ZeroClipboard object
#     @param   {String} sData the data to be set
#     @returns void
#     @private
#     ###
#     _fnFlashSetText: (clip, sData) ->
#       asData = @_fnChunkData(sData, 8192)
#       clip.clearText()
#       i = 0
#       iLen = asData.length
# 
#       while i < iLen
#         clip.appendText asData[i]
#         i++
# 
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Data retrieval functions
#     #	 
#     
#     ###
#     Convert the mixed columns variable into a boolean array the same size as the columns, which
#     indicates which columns we want to include
#     @method  _fnColumnTargets
#     @param   {String|Array} mColumns The columns to be included in data retrieval. If a string
#     then it can take the value of "visible" or "hidden" (to include all visible or
#     hidden columns respectively). Or an array of column indexes
#     @returns {Array} A boolean array the length of the columns of the table, which each value
#     indicating if the column is to be included or not
#     @private
#     ###
#     _fnColumnTargets: (mColumns) ->
#       aColumns = []
#       dt = @s.dt
#       if typeof mColumns is "object"
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           aColumns.push false
#           i++
#         i = 0
#         iLen = mColumns.length
# 
#         while i < iLen
#           aColumns[mColumns[i]] = true
#           i++
#       else if mColumns is "visible"
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           aColumns.push (if dt.aoColumns[i].bVisible then true else false)
#           i++
#       else if mColumns is "hidden"
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           aColumns.push (if dt.aoColumns[i].bVisible then false else true)
#           i++
#       else if mColumns is "sortable"
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           aColumns.push (if dt.aoColumns[i].bSortable then true else false)
#           i++
#       # all 
#       else
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           aColumns.push true
#           i++
#       aColumns
# 
#     
#     ###
#     New line character(s) depend on the platforms
#     @method  method
#     @param   {Object} oConfig Button configuration object - only interested in oConfig.sNewLine
#     @returns {String} Newline character
#     ###
#     _fnNewline: (oConfig) ->
#       if oConfig.sNewLine is "auto"
#         (if navigator.userAgent.match(/Windows/) then "\r\n" else "\n")
#       else
#         oConfig.sNewLine
# 
#     
#     ###
#     Get data from DataTables' internals and format it for output
#     @method  _fnGetDataTablesData
#     @param   {Object} oConfig Button configuration object
#     @param   {String} oConfig.sFieldBoundary Field boundary for the data cells in the string
#     @param   {String} oConfig.sFieldSeperator Field separator for the data cells
#     @param   {String} oConfig.sNewline New line options
#     @param   {Mixed} oConfig.mColumns Which columns should be included in the output
#     @param   {Boolean} oConfig.bHeader Include the header
#     @param   {Boolean} oConfig.bFooter Include the footer
#     @param   {Boolean} oConfig.bSelectedOnly Include only the selected rows in the output
#     @returns {String} Concatenated string of data
#     @private
#     ###
#     _fnGetDataTablesData: (oConfig) ->
#       i = undefined
#       iLen = undefined
#       j = undefined
#       jLen = undefined
#       aRow = undefined
#       aData = []
#       sLoopData = ""
#       arr = undefined
#       dt = @s.dt
#       tr = undefined
#       child = undefined
#       regex = new RegExp(oConfig.sFieldBoundary, "g") # Do it here for speed
#       aColumnsInc = @_fnColumnTargets(oConfig.mColumns)
#       bSelectedOnly = (if (typeof oConfig.bSelectedOnly isnt "undefined") then oConfig.bSelectedOnly else false)
#       
#       #
#       #		 * Header
#       #		 
#       if oConfig.bHeader
#         aRow = []
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           if aColumnsInc[i]
#             sLoopData = dt.aoColumns[i].sTitle.replace(/\n/g, " ").replace(/<.*?>/g, "").replace(/^\s+|\s+$/g, "")
#             sLoopData = @_fnHtmlDecode(sLoopData)
#             aRow.push @_fnBoundData(sLoopData, oConfig.sFieldBoundary, regex)
#           i++
#         aData.push aRow.join(oConfig.sFieldSeperator)
#       
#       #
#       #		 * Body
#       #		 
#       aDataIndex = dt.aiDisplay
#       aSelected = @fnGetSelected()
#       if @s.select.type isnt "none" and bSelectedOnly and aSelected.length isnt 0
#         aDataIndex = []
#         i = 0
#         iLen = aSelected.length
# 
#         while i < iLen
#           aDataIndex.push dt.oInstance.fnGetPosition(aSelected[i])
#           i++
#       j = 0
#       jLen = aDataIndex.length
# 
#       while j < jLen
#         tr = dt.aoData[aDataIndex[j]].nTr
#         aRow = []
#         
#         # Columns 
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           if aColumnsInc[i]
#             
#             # Convert to strings (with small optimisation) 
#             mTypeData = dt.oApi._fnGetCellData(dt, aDataIndex[j], i, "display")
#             if oConfig.fnCellRender
#               sLoopData = oConfig.fnCellRender(mTypeData, i, tr, aDataIndex[j]) + ""
#             else if typeof mTypeData is "string"
#               
#               # Strip newlines, replace img tags with alt attr. and finally strip html... 
#               sLoopData = mTypeData.replace(/\n/g, " ")
#               sLoopData = sLoopData.replace(/<img.*?\s+alt\s*=\s*(?:"([^"]+)"|'([^']+)'|([^\s>]+)).*?>/g, "$1$2$3")
#               sLoopData = sLoopData.replace(/<.*?>/g, "")
#             else
#               sLoopData = mTypeData + ""
#             
#             # Trim and clean the data 
#             sLoopData = sLoopData.replace(/^\s+/, "").replace(/\s+$/, "")
#             sLoopData = @_fnHtmlDecode(sLoopData)
#             
#             # Bound it and add it to the total data 
#             aRow.push @_fnBoundData(sLoopData, oConfig.sFieldBoundary, regex)
#           i++
#         aData.push aRow.join(oConfig.sFieldSeperator)
#         
#         # Details rows from fnOpen 
#         if oConfig.bOpenRows
#           arr = $.grep(dt.aoOpenRows, (o) ->
#             o.nParent is tr
#           )
#           if arr.length is 1
#             sLoopData = @_fnBoundData($("td", arr[0].nTr).html(), oConfig.sFieldBoundary, regex)
#             aData.push sLoopData
#         j++
#       
#       #
#       #		 * Footer
#       #		 
#       if oConfig.bFooter and dt.nTFoot isnt null
#         aRow = []
#         i = 0
#         iLen = dt.aoColumns.length
# 
#         while i < iLen
#           if aColumnsInc[i] and dt.aoColumns[i].nTf isnt null
#             sLoopData = dt.aoColumns[i].nTf.innerHTML.replace(/\n/g, " ").replace(/<.*?>/g, "")
#             sLoopData = @_fnHtmlDecode(sLoopData)
#             aRow.push @_fnBoundData(sLoopData, oConfig.sFieldBoundary, regex)
#           i++
#         aData.push aRow.join(oConfig.sFieldSeperator)
#       _sLastData = aData.join(@_fnNewline(oConfig))
#       _sLastData
# 
#     
#     ###
#     Wrap data up with a boundary string
#     @method  _fnBoundData
#     @param   {String} sData data to bound
#     @param   {String} sBoundary bounding char(s)
#     @param   {RegExp} regex search for the bounding chars - constructed outside for efficiency
#     in the loop
#     @returns {String} bound data
#     @private
#     ###
#     _fnBoundData: (sData, sBoundary, regex) ->
#       if sBoundary is ""
#         sData
#       else
#         sBoundary + sData.replace(regex, sBoundary + sBoundary) + sBoundary
# 
#     
#     ###
#     Break a string up into an array of smaller strings
#     @method  _fnChunkData
#     @param   {String} sData data to be broken up
#     @param   {Int} iSize chunk size
#     @returns {Array} String array of broken up text
#     @private
#     ###
#     _fnChunkData: (sData, iSize) ->
#       asReturn = []
#       iStrlen = sData.length
#       i = 0
# 
#       while i < iStrlen
#         if i + iSize < iStrlen
#           asReturn.push sData.substring(i, i + iSize)
#         else
#           asReturn.push sData.substring(i, iStrlen)
#         i += iSize
#       asReturn
# 
#     
#     ###
#     Decode HTML entities
#     @method  _fnHtmlDecode
#     @param   {String} sData encoded string
#     @returns {String} decoded string
#     @private
#     ###
#     _fnHtmlDecode: (sData) ->
#       return sData  if sData.indexOf("&") is -1
#       aData = @_fnChunkData(sData, 2048)
#       n = document.createElement("div")
#       i = undefined
#       iLen = undefined
#       iIndex = undefined
#       sReturn = ""
#       sInner = undefined
#       
#       # nodeValue has a limit in browsers - so we chunk the data into smaller segments to build
#       #		 * up the string. Note that the 'trick' here is to remember than we might have split over
#       #		 * an HTML entity, so we backtrack a little to make sure this doesn't happen
#       #		 
#       i = 0
#       iLen = aData.length
# 
#       while i < iLen
#         
#         # Magic number 8 is because no entity is longer then strlen 8 in ISO 8859-1 
#         iIndex = aData[i].lastIndexOf("&")
#         if iIndex isnt -1 and aData[i].length >= 8 and iIndex > aData[i].length - 8
#           sInner = aData[i].substr(iIndex)
#           aData[i] = aData[i].substr(0, iIndex)
#         n.innerHTML = aData[i]
#         sReturn += n.childNodes[0].nodeValue
#         i++
#       sReturn
# 
#     
#     # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#     #	 * Printing functions
#     #	 
#     
#     ###
#     Show print display
#     @method  _fnPrintStart
#     @param   {Event} e Event object
#     @param   {Object} oConfig Button configuration object
#     @returns void
#     @private
#     ###
#     _fnPrintStart: (oConfig) ->
#       that = this
#       oSetDT = @s.dt
#       
#       # Parse through the DOM hiding everything that isn't needed for the table 
#       @_fnPrintHideNodes oSetDT.nTable
#       
#       # Show the whole table 
#       @s.print.saveStart = oSetDT._iDisplayStart
#       @s.print.saveLength = oSetDT._iDisplayLength
#       if oConfig.bShowAll
#         oSetDT._iDisplayStart = 0
#         oSetDT._iDisplayLength = -1
#         oSetDT.oApi._fnCalculateEnd oSetDT
#         oSetDT.oApi._fnDraw oSetDT
#       
#       # Adjust the display for scrolling which might be done by DataTables 
#       @_fnPrintScrollStart oSetDT  if oSetDT.oScroll.sX isnt "" or oSetDT.oScroll.sY isnt ""
#       
#       # Remove the other DataTables feature nodes - but leave the table! and info div 
#       anFeature = oSetDT.aanFeatures
#       for cFeature of anFeature
#         if cFeature isnt "i" and cFeature isnt "t" and cFeature.length is 1
#           i = 0
#           iLen = anFeature[cFeature].length
# 
#           while i < iLen
#             @dom.print.hidden.push
#               node: anFeature[cFeature][i]
#               display: "block"
# 
#             anFeature[cFeature][i].style.display = "none"
#             i++
#       
#       # Print class can be used for styling 
#       $(document.body).addClass @classes.print.body
#       
#       # Show information message to let the user know what is happening 
#       @fnInfo oConfig.sInfo, 3000  if oConfig.sInfo isnt ""
#       
#       # Add a message at the top of the page 
#       if oConfig.sMessage
#         @dom.print.message = document.createElement("div")
#         @dom.print.message.className = @classes.print.message
#         @dom.print.message.innerHTML = oConfig.sMessage
#         document.body.insertBefore @dom.print.message, document.body.childNodes[0]
#       
#       # Cache the scrolling and the jump to the top of the page 
#       @s.print.saveScroll = $(window).scrollTop()
#       window.scrollTo 0, 0
#       
#       # Bind a key event listener to the document for the escape key -
#       #		 * it is removed in the callback
#       #		 
#       $(document).bind "keydown.DTTT", (e) ->
#         
#         # Only interested in the escape key 
#         if e.keyCode is 27
#           e.preventDefault()
#           that._fnPrintEnd.call that, e
# 
# 
#     
#     ###
#     Printing is finished, resume normal display
#     @method  _fnPrintEnd
#     @param   {Event} e Event object
#     @returns void
#     @private
#     ###
#     _fnPrintEnd: (e) ->
#       that = this
#       oSetDT = @s.dt
#       oSetPrint = @s.print
#       oDomPrint = @dom.print
#       
#       # Show all hidden nodes 
#       @_fnPrintShowNodes()
#       
#       # Restore DataTables' scrolling 
#       @_fnPrintScrollEnd()  if oSetDT.oScroll.sX isnt "" or oSetDT.oScroll.sY isnt ""
#       
#       # Restore the scroll 
#       window.scrollTo 0, oSetPrint.saveScroll
#       
#       # Drop the print message 
#       if oDomPrint.message isnt null
#         document.body.removeChild oDomPrint.message
#         oDomPrint.message = null
#       
#       # Styling class 
#       $(document.body).removeClass "DTTT_Print"
#       
#       # Restore the table length 
#       oSetDT._iDisplayStart = oSetPrint.saveStart
#       oSetDT._iDisplayLength = oSetPrint.saveLength
#       oSetDT.oApi._fnCalculateEnd oSetDT
#       oSetDT.oApi._fnDraw oSetDT
#       $(document).unbind "keydown.DTTT"
# 
#     
#     ###
#     Take account of scrolling in DataTables by showing the full table
#     @returns void
#     @private
#     ###
#     _fnPrintScrollStart: ->
#       oSetDT = @s.dt
#       nScrollHeadInner = oSetDT.nScrollHead.getElementsByTagName("div")[0]
#       nScrollHeadTable = nScrollHeadInner.getElementsByTagName("table")[0]
#       nScrollBody = oSetDT.nTable.parentNode
#       
#       # Copy the header in the thead in the body table, this way we show one single table when
#       #		 * in print view. Note that this section of code is more or less verbatim from DT 1.7.0
#       #		 
#       nTheadSize = oSetDT.nTable.getElementsByTagName("thead")
#       oSetDT.nTable.removeChild nTheadSize[0]  if nTheadSize.length > 0
#       if oSetDT.nTFoot isnt null
#         nTfootSize = oSetDT.nTable.getElementsByTagName("tfoot")
#         oSetDT.nTable.removeChild nTfootSize[0]  if nTfootSize.length > 0
#       nTheadSize = oSetDT.nTHead.cloneNode(true)
#       oSetDT.nTable.insertBefore nTheadSize, oSetDT.nTable.childNodes[0]
#       if oSetDT.nTFoot isnt null
#         nTfootSize = oSetDT.nTFoot.cloneNode(true)
#         oSetDT.nTable.insertBefore nTfootSize, oSetDT.nTable.childNodes[1]
#       
#       # Now adjust the table's viewport so we can actually see it 
#       if oSetDT.oScroll.sX isnt ""
#         oSetDT.nTable.style.width = $(oSetDT.nTable).outerWidth() + "px"
#         nScrollBody.style.width = $(oSetDT.nTable).outerWidth() + "px"
#         nScrollBody.style.overflow = "visible"
#       if oSetDT.oScroll.sY isnt ""
#         nScrollBody.style.height = $(oSetDT.nTable).outerHeight() + "px"
#         nScrollBody.style.overflow = "visible"
# 
#     
#     ###
#     Take account of scrolling in DataTables by showing the full table. Note that the redraw of
#     the DataTable that we do will actually deal with the majority of the hard work here
#     @returns void
#     @private
#     ###
#     _fnPrintScrollEnd: ->
#       oSetDT = @s.dt
#       nScrollBody = oSetDT.nTable.parentNode
#       if oSetDT.oScroll.sX isnt ""
#         nScrollBody.style.width = oSetDT.oApi._fnStringToCss(oSetDT.oScroll.sX)
#         nScrollBody.style.overflow = "auto"
#       if oSetDT.oScroll.sY isnt ""
#         nScrollBody.style.height = oSetDT.oApi._fnStringToCss(oSetDT.oScroll.sY)
#         nScrollBody.style.overflow = "auto"
# 
#     
#     ###
#     Resume the display of all TableTools hidden nodes
#     @method  _fnPrintShowNodes
#     @returns void
#     @private
#     ###
#     _fnPrintShowNodes: ->
#       anHidden = @dom.print.hidden
#       i = 0
#       iLen = anHidden.length
# 
#       while i < iLen
#         anHidden[i].node.style.display = anHidden[i].display
#         i++
#       anHidden.splice 0, anHidden.length
# 
#     
#     ###
#     Hide nodes which are not needed in order to display the table. Note that this function is
#     recursive
#     @method  _fnPrintHideNodes
#     @param   {Node} nNode Element which should be showing in a 'print' display
#     @returns void
#     @private
#     ###
#     _fnPrintHideNodes: (nNode) ->
#       anHidden = @dom.print.hidden
#       nParent = nNode.parentNode
#       nChildren = nParent.childNodes
#       i = 0
#       iLen = nChildren.length
# 
#       while i < iLen
#         if nChildren[i] isnt nNode and nChildren[i].nodeType is 1
#           
#           # If our node is shown (don't want to show nodes which were previously hidden) 
#           sDisplay = $(nChildren[i]).css("display")
#           unless sDisplay is "none"
#             
#             # Cache the node and it's previous state so we can restore it 
#             anHidden.push
#               node: nChildren[i]
#               display: sDisplay
# 
#             nChildren[i].style.display = "none"
#         i++
#       @_fnPrintHideNodes nParent  unless nParent.nodeName is "BODY"
# 
#   
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   # * Static variables
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#   
#   ###
#   Store of all instances that have been created of TableTools, so one can look up other (when
#   there is need of a master)
#   @property _aInstances
#   @type	 Array
#   @default  []
#   @private
#   ###
#   TableTools._aInstances = []
#   
#   ###
#   Store of all listeners and their callback functions
#   @property _aListeners
#   @type	 Array
#   @default  []
#   ###
#   TableTools._aListeners = []
#   
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   # * Static methods
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#   
#   ###
#   Get an array of all the master instances
#   @method  fnGetMasters
#   @returns {Array} List of master TableTools instances
#   @static
#   ###
#   TableTools.fnGetMasters = ->
#     a = []
#     i = 0
#     iLen = TableTools._aInstances.length
# 
#     while i < iLen
#       a.push TableTools._aInstances[i]  if TableTools._aInstances[i].s.master
#       i++
#     a
# 
#   
#   ###
#   Get the master instance for a table node (or id if a string is given)
#   @method  fnGetInstance
#   @returns {Object} ID of table OR table node, for which we want the TableTools instance
#   @static
#   ###
#   TableTools.fnGetInstance = (node) ->
#     node = document.getElementById(node)  unless typeof node is "object"
#     i = 0
#     iLen = TableTools._aInstances.length
# 
#     while i < iLen
#       return TableTools._aInstances[i]  if TableTools._aInstances[i].s.master and TableTools._aInstances[i].dom.table is node
#       i++
#     null
# 
#   
#   ###
#   Add a listener for a specific event
#   @method  _fnEventListen
#   @param   {Object} that Scope of the listening function (i.e. 'this' in the caller)
#   @param   {String} type Event type
#   @param   {Function} fn Function
#   @returns void
#   @private
#   @static
#   ###
#   TableTools._fnEventListen = (that, type, fn) ->
#     TableTools._aListeners.push
#       that: that
#       type: type
#       fn: fn
# 
# 
#   
#   ###
#   An event has occurred - look up every listener and fire it off. We check that the event we are
#   going to fire is attached to the same table (using the table node as reference) before firing
#   @method  _fnEventDispatch
#   @param   {Object} that Scope of the listening function (i.e. 'this' in the caller)
#   @param   {String} type Event type
#   @param   {Node} node Element that the event occurred on (may be null)
#   @returns void
#   @private
#   @static
#   ###
#   TableTools._fnEventDispatch = (that, type, node) ->
#     listeners = TableTools._aListeners
#     i = 0
#     iLen = listeners.length
# 
#     while i < iLen
#       listeners[i].fn node  if that.dom.table is listeners[i].that.dom.table and listeners[i].type is type
#       i++
# 
#   
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   # * Constants
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#   TableTools.buttonBase =
#     
#     # Button base
#     sAction: "text"
#     sTag: "default"
#     sLinerTag: "default"
#     sButtonClass: "DTTT_button_text"
#     sButtonText: "Button text"
#     sTitle: ""
#     sToolTip: ""
#     
#     # Common button specific options
#     sCharSet: "utf8"
#     bBomInc: false
#     sFileName: "*.csv"
#     sFieldBoundary: ""
#     sFieldSeperator: "\t"
#     sNewLine: "auto"
#     mColumns: "all" # "all", "visible", "hidden" or array of column integers
#     bHeader: true
#     bFooter: true
#     bOpenRows: false
#     bSelectedOnly: false
#     
#     # Callbacks
#     fnMouseover: null
#     fnMouseout: null
#     fnClick: null
#     fnSelect: null
#     fnComplete: null
#     fnInit: null
#     fnCellRender: null
# 
#   
#   ###
#   @namespace Default button configurations
#   ###
#   TableTools.BUTTONS =
#     csv: $.extend({}, TableTools.buttonBase,
#       sAction: "flash_save"
#       sButtonClass: "DTTT_button_csv"
#       sButtonText: "CSV"
#       sFieldBoundary: "\""
#       sFieldSeperator: ","
#       fnClick: (nButton, oConfig, flash) ->
#         @fnSetText flash, @fnGetTableData(oConfig)
#     )
#     xls: $.extend({}, TableTools.buttonBase,
#       sAction: "flash_save"
#       sCharSet: "utf16le"
#       bBomInc: true
#       sButtonClass: "DTTT_button_xls"
#       sButtonText: "Excel"
#       fnClick: (nButton, oConfig, flash) ->
#         @fnSetText flash, @fnGetTableData(oConfig)
#     )
#     copy: $.extend({}, TableTools.buttonBase,
#       sAction: "flash_copy"
#       sButtonClass: "DTTT_button_copy"
#       sButtonText: "Copy"
#       fnClick: (nButton, oConfig, flash) ->
#         @fnSetText flash, @fnGetTableData(oConfig)
# 
#       fnComplete: (nButton, oConfig, flash, text) ->
#         lines = text.split("\n").length
#         len = (if @s.dt.nTFoot is null then lines - 1 else lines - 2)
#         plural = (if (len is 1) then "" else "s")
#         @fnInfo "<h6>Table copied</h6>" + "<p>Copied " + len + " row" + plural + " to the clipboard.</p>", 1500
#     )
#     pdf: $.extend({}, TableTools.buttonBase,
#       sAction: "flash_pdf"
#       sNewLine: "\n"
#       sFileName: "*.pdf"
#       sButtonClass: "DTTT_button_pdf"
#       sButtonText: "PDF"
#       sPdfOrientation: "portrait"
#       sPdfSize: "A4"
#       sPdfMessage: ""
#       fnClick: (nButton, oConfig, flash) ->
#         @fnSetText flash, "title:" + @fnGetTitle(oConfig) + "\n" + "message:" + oConfig.sPdfMessage + "\n" + "colWidth:" + @fnCalcColRatios(oConfig) + "\n" + "orientation:" + oConfig.sPdfOrientation + "\n" + "size:" + oConfig.sPdfSize + "\n" + "--/TableToolsOpts--\n" + @fnGetTableData(oConfig)
#     )
#     print: $.extend({}, TableTools.buttonBase,
#       sInfo: "<h6>Print view</h6><p>Please use your browser's print function to " + "print this table. Press escape when finished."
#       sMessage: null
#       bShowAll: true
#       sToolTip: "View print view"
#       sButtonClass: "DTTT_button_print"
#       sButtonText: "Print"
#       fnClick: (nButton, oConfig) ->
#         @fnPrint true, oConfig
#     )
#     text: $.extend({}, TableTools.buttonBase)
#     select: $.extend({}, TableTools.buttonBase,
#       sButtonText: "Select button"
#       fnSelect: (nButton, oConfig) ->
#         if @fnGetSelected().length isnt 0
#           $(nButton).removeClass @classes.buttons.disabled
#         else
#           $(nButton).addClass @classes.buttons.disabled
# 
#       fnInit: (nButton, oConfig) ->
#         $(nButton).addClass @classes.buttons.disabled
#     )
#     select_single: $.extend({}, TableTools.buttonBase,
#       sButtonText: "Select button"
#       fnSelect: (nButton, oConfig) ->
#         iSelected = @fnGetSelected().length
#         if iSelected is 1
#           $(nButton).removeClass @classes.buttons.disabled
#         else
#           $(nButton).addClass @classes.buttons.disabled
# 
#       fnInit: (nButton, oConfig) ->
#         $(nButton).addClass @classes.buttons.disabled
#     )
#     select_all: $.extend({}, TableTools.buttonBase,
#       sButtonText: "Select all"
#       fnClick: (nButton, oConfig) ->
#         @fnSelectAll()
# 
#       fnSelect: (nButton, oConfig) ->
#         if @fnGetSelected().length is @s.dt.fnRecordsDisplay()
#           $(nButton).addClass @classes.buttons.disabled
#         else
#           $(nButton).removeClass @classes.buttons.disabled
#     )
#     select_none: $.extend({}, TableTools.buttonBase,
#       sButtonText: "Deselect all"
#       fnClick: (nButton, oConfig) ->
#         @fnSelectNone()
# 
#       fnSelect: (nButton, oConfig) ->
#         if @fnGetSelected().length isnt 0
#           $(nButton).removeClass @classes.buttons.disabled
#         else
#           $(nButton).addClass @classes.buttons.disabled
# 
#       fnInit: (nButton, oConfig) ->
#         $(nButton).addClass @classes.buttons.disabled
#     )
#     ajax: $.extend({}, TableTools.buttonBase,
#       sAjaxUrl: "/xhr.php"
#       sButtonText: "Ajax button"
#       fnClick: (nButton, oConfig) ->
#         sData = @fnGetTableData(oConfig)
#         $.ajax
#           url: oConfig.sAjaxUrl
#           data: [
#             name: "tableData"
#             value: sData
#           ]
#           success: oConfig.fnAjaxComplete
#           dataType: "json"
#           type: "POST"
#           cache: false
#           error: ->
#             alert "Error detected when sending table data to server"
# 
# 
#       fnAjaxComplete: (json) ->
#         alert "Ajax complete"
#     )
#     div: $.extend({}, TableTools.buttonBase,
#       sAction: "div"
#       sTag: "div"
#       sButtonClass: "DTTT_nonbutton"
#       sButtonText: "Text button"
#     )
#     collection: $.extend({}, TableTools.buttonBase,
#       sAction: "collection"
#       sButtonClass: "DTTT_button_collection"
#       sButtonText: "Collection"
#       fnClick: (nButton, oConfig) ->
#         @_fnCollectionShow nButton, oConfig
#     )
# 
#   
#   #
#   # *  on* callback parameters:
#   # *  	1. node - button element
#   # *  	2. object - configuration object for this button
#   # *  	3. object - ZeroClipboard reference (flash button only)
#   # *  	4. string - Returned string from Flash (flash button only - and only on 'complete')
#   # 
#   
#   ###
#   @namespace Classes used by TableTools - allows the styles to be override easily.
#   Note that when TableTools initialises it will take a copy of the classes object
#   and will use its internal copy for the remainder of its run time.
#   ###
#   TableTools.classes =
#     container: "DTTT_container"
#     buttons:
#       normal: "DTTT_button"
#       disabled: "DTTT_disabled"
# 
#     collection:
#       container: "DTTT_collection"
#       background: "DTTT_collection_background"
#       buttons:
#         normal: "DTTT_button"
#         disabled: "DTTT_disabled"
# 
#     select:
#       table: "DTTT_selectable"
#       row: "DTTT_selected"
# 
#     print:
#       body: "DTTT_Print"
#       info: "DTTT_print_info"
#       message: "DTTT_PrintMessage"
# 
#   
#   ###
#   @namespace ThemeRoller classes - built in for compatibility with DataTables'
#   bJQueryUI option.
#   ###
#   TableTools.classes_themeroller =
#     container: "DTTT_container ui-buttonset ui-buttonset-multi"
#     buttons:
#       normal: "DTTT_button ui-button ui-state-default"
# 
#     collection:
#       container: "DTTT_collection ui-buttonset ui-buttonset-multi"
# 
#   
#   ###
#   @namespace TableTools default settings for initialisation
#   ###
#   TableTools.DEFAULTS =
#     sSwfPath: "media/swf/copy_csv_xls_pdf.swf"
#     sRowSelect: "none"
#     sSelectedClass: null
#     fnPreRowSelect: null
#     fnRowSelected: null
#     fnRowDeselected: null
#     aButtons: ["copy", "csv", "xls", "pdf", "print"]
#     oTags:
#       container: "div"
#       button: "a" # We really want to use buttons here, but Firefox and IE ignore the
#       # click on the Flash element in the button (but not mouse[in|out]).
#       liner: "span"
#       collection:
#         container: "div"
#         button: "a"
#         liner: "span"
# 
#   
#   ###
#   Name of this class
#   @constant CLASS
#   @type	 String
#   @default  TableTools
#   ###
#   TableTools::CLASS = "TableTools"
#   
#   ###
#   TableTools version
#   @constant  VERSION
#   @type	  String
#   @default   See code
#   ###
#   TableTools.VERSION = "2.1.3"
#   TableTools::VERSION = TableTools.VERSION
#   
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   # * Initialisation
#   # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#   
#   #
#   # * Register a new feature with DataTables
#   # 
#   if typeof $.fn.dataTable is "function" and typeof $.fn.dataTableExt.fnVersionCheck is "function" and $.fn.dataTableExt.fnVersionCheck("1.9.0")
#     $.fn.dataTableExt.aoFeatures.push
#       fnInit: (oDTSettings) ->
#         oOpts = (if typeof oDTSettings.oInit.oTableTools isnt "undefined" then oDTSettings.oInit.oTableTools else {})
#         oTT = new TableTools(oDTSettings.oInstance, oOpts)
#         TableTools._aInstances.push oTT
#         oTT.dom.container
# 
#       cFeature: "T"
#       sFeature: "TableTools"
# 
#   else
#     alert "Warning: TableTools 2 requires DataTables 1.9.0 or newer - www.datatables.net/download"
#   $.fn.DataTable.TableTools = TableTools
# ) jQuery, window, document