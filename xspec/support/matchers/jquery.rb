# RSpec::Matchers.define :have_accordion do |expected|
#   match do |elem|
#     puts elem.class
#     elem.has_css('.ui-accordion')
#   end
# 
#   failure_message_for_should do |elem|
#     "Expected #{elem} to have an accordion"
#   end
#   
#   failure_message_for_should_not do |elem|
#     "Expected #{elem} to not chave an accordion"
#   end
#   
#   description do
#     "expected an accordion"
#   end
# end
