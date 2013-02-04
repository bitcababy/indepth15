module JqueryHelpers

  def find_accordion_pane(n)
    within '.ui-accordion' do
      panes = page.all('.pane-title')
      return panes[n]
    end
  end
  
end

