require 'rails_helper'

RSpec.describe Department do
  it { is_expected.to embed_many :homepage_docs }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to have_many :courses }

  let(:dept) { create :department, full_name: 'State' }

  it "describes itself with its full name" do
    expect(dept.describe).to eq("State")
  end

end
