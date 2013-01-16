# ###
# @license Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
# For licensing, see LICENSE.html or http://ckeditor.com/license
# ###
# CKEDITOR.editorConfig = (config) ->
#   
#   # Define changes to default configuration here.
#   # For the complete reference:
#   # http://docs.ckeditor.com/#!/api/CKEDITOR.config
#   
#   # The toolbar groups arrangement, optimized for two toolbar rows.
# 	config.toolbarGroups = [
# 	  name: "clipboard"
# 	  groups: ["clipboard", "undo"]
# 	,
# 	  name: "editing"
# 	  groups: ["find", "selection", "spellchecker"]
# 	,
# 	  name: "links"
# 	,
# 	  name: "insert"
# 	,
# 	  name: "forms"
# 	,
# 	  name: "tools"
# 	,
# 	  name: "document"
# 	  groups: ["mode"]
# 	,
# 	  name: "others"
# 	, "/",
# 	  name: "basicstyles"
# 	  groups: ["basicstyles", "cleanup"]
# 	,
# 	  name: "paragraph"
# 	  groups: ["list", "indent", "blocks", "align"]
# 	,
# 	  name: "styles"
# 	,
# 	  name: "colors"
# 	,
# 	  name: "about"
# 	]
# 	config.toolbar = [
# 	  name: "document"
# 	  items: ["Source"]
# 	,
# 	  name: "clipboard"
# 	  items: ["Cut", "Copy", "Paste", "PasteText", "PasteFromWord", "-", "Undo", "Redo"]
# 	, "/",
# 	  name: "basicstyles"
# 	  items: ["Bold", "Italic"]
# 	]	
# 	
# 	
#   # Remove some buttons, provided by the standard plugins, which we don't
#   # need to have in the Standard(s) toolbar.
# 	config.removeButtons = "Underline"
# 	config.autoGrow_onStartup = true
# 	config.resize_enabled = false
# 	