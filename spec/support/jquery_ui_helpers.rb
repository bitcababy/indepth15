module JqueryUIHelpers
  def assert_accordion_open
    page.should have_selector('.ui-accordion')
  end
  
  def assert_dialog_open
    page.should have_selector('ui-dialog')
  end

  def find_accordion_pane(n)
    within '.ui-accordion' do
      panes = page.all('.pane-title')
      return panes[n]
    end
  end
end

