module ViewMacros
  def as_user
    view.stub(:user_signed_in?).and_return true
    view.stub(:editable?).and_return true
    yield if block_given?
  end
  
  def as_guest
    view.stub(:user_signed_in?).and_return false
    view.stub(:editable?).and_return false
    yield if block_given?
  end
  
  def page
    Capybara.string rendered
  end
  
end

RSpec.configure do |config|
  config.include ViewMacros, :type => :view
end
