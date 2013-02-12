module DeviseHelpers
  def as_user(user=nil, &block)
    current_user = user || Fabricate(:user)
    if request.present?
      sign_in(current_user)
    else
      login_as(current_user, :scope => :user)
    end
    request.env['devise.mapping'] = Devise.mappings[:user]
    block.call if block.present?
    return self
  end

  def as_visitor(user=nil, &block)
    current_user = user || Fabricate.stub(:user)
    if request.present?
      sign_out(current_user)
    else
      logout(:user)
    end
    block.call if block.present?
    return self
  end
end

RSpec.configure do |config|
  config.extend DeviseHelpers
end
