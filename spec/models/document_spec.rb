require 'spec_helper'

describe Document do
   subject = Fabricate :document
   it { should be_unlocked }
  
  describe '<=>' do
    subject.position = 1
    doc = Fabricate :document, position: 2
    subject.should < doc
  end  
    
end
