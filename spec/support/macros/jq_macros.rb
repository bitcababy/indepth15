# module JQMacros
#   def wait_for_ajax
#     wait_until { page.evaluate_script("jQuery.active") == 0 }
#   end
# end
# 
# 
# RSpec.configure do |config|
#   config.extend JQMacros
# end
