require 'rails_helper'
require 'due_date'

class TestClass
  include DueDate
end


RSpec.describe 'DueDate' do
  let(:obj) { TestClass.new }

  it "knows about the next school day" do
    today = Date.today
    if today.friday? || today.saturday?
      expect(obj.next_school_day.monday?).to be_truthy
    else
      expect(obj.next_school_day).to eq(today + 1)
    end
  end


end
