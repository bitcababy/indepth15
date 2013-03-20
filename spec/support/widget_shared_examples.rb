shared_examples_for 'a widget' do
  it "displays as if it were a widget" do
    render
    expect(rendered).to have_selector '.ui-widget'
    widget = page.find('ui-widget')
    expect(widget).to have_selector '.ui-widget-header'
    expect(widget).to have_selector '.ui-widget-content'
  end
end
  