require 'spec_helper'

describe 'datepicker_input' do
  include InputExampleGroup

  before do
    concat input_for(:foo, :due_date, as: :datepicker)
  end
  
  it "should have a label" do
    assert_select 'foo[due_date]'
  end
end
