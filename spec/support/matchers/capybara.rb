RSpec::Matchers.define :have_class do |cl|
  match do |el|
    el[:class].split(' ').contains? cl
  end

  failure_message_for_should do |elem|
    "Expected #{elem} to have class #{cl}"
  end
  
  failure_message_for_should_not do |elem|
    "Expected #{elem} to not contain #{cl}"
  end
  
  description do
    "expected an element with class #{cl}"
  end
end

# # RSpec::Matchers.define :have_cells do |expected|
#   match do |actual|
#     match.cells == actual
#   end
# 
#   description do
#     "expected #{expected} to equal #{actual}"
#   end
# 
#   failure_message_for_should do |elem|
#     "Expected #{expected} to equal #{actual}"
#   end
#   
#   failure_message_for_should_not do |elem|
#     "Expected #{expected} to not equal #{elem}"
#   end
#   
# end
# 
# #   
# # RSpec::Matchers.define :exist do
# #   match do |cond|
# #     cond.exists?
# #   end
# # 
# #   failure_message_for_should do |cond|
# #     "Expected #{cond} to exist"
# #   end
# #   
# #   failure_message_for_should_not do |cond|
# #     "Expected #{cond} to not exist"
# #   end
# #   
# #   description do |cond|
# #     "Tests whethere an object exists"
# #   end
# # end
# #   
# # 
