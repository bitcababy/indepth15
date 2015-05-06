require 'spec_helper'

describe Name do
  # it "can be created by demongoizing" do
  #   n = Name.demongoize first: "John", middle: nil, last: "Doe", known_as: nil, honorific: nil, suffix: nil
  #   expect(n).to be_kind_of Name
  #   expect(n.first).to eq "John"
  #   expect(n.last).to eq "Doe"
  # end
  # 
  # it "mongoizes itself" do
  #   n = Name.from_hash first: "John", last: "Doe"
  #   expect([n.mongoize]).to eq [first: "John", middle: nil, last: "Doe", known_as: nil, honorific: nil, suffix: nil]
  # end
  # 
  # it "is comparable" do
  #   n1 = Name.from_hash(first: "John", last: "Doe")
  #   n2 = Name.from_hash(first: "John", last: "Doe")
  #   n3 = Name.from_hash(first: "John", last: "Roe")
  #   expect(n1.first).to eq n2.first
  #   expect(n1).to eq n2
  #   pending "unfinished test"
  #   expect(n1).to be < n3
  # end
  #   
  # it "returns a formal name" do
  #   n = Name.from_hash first: "John", last: "Doe", honorific: "Mr."
  #   expect(n.to_formal).to eq "Mr. Doe"
  # end
  # 
  # it "returns a full name" do
  #   n = Name.from_hash first: "John", last: "Doe", honorific: "Mr."
  #   expect(n.to_full).to eq "John Doe"
  # end
    
end
