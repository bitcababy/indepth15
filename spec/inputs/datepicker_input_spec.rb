require 'spec_helper'

describe 'datepicker_input' do
  include InputExampleGroup

  before do
    concat input_for(:foo, :due_date, as: :datepicker)
  end
  
end
