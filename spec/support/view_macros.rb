module ViewMacros
  def as_user
    view.stubs(:editable?).returns true
  end

  def as_guest
    view.stubs(:editable?).returns false
  end
end