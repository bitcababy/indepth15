require 'rails_helper'

class ClassWithName
  include NamedObject
end

RSpec.describe ClassWithName do
  let (:name) { ClassWithName.new honorific: "Mr.", first_name: "Roger", last_name: "Rabbit" }

  it "holds the parts of a name" do
    name = ClassWithName.new honorific: "Mr.", first_name: "Roger", last_name: "Rabbit"
    expect(name.honorific).to eq("Mr.")
    expect(name.first_name).to eq("Roger")
    expect(name.last_name).to eq("Rabbit")
  end

  it "returns a formal name" do
    expect(name.formal_name).to eq("Mr. Rabbit")
  end

  it "returns a full name" do
    expect(name.full_name).to eq("Roger Rabbit")
  end
end
