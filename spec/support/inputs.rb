# From http://brainspec.com/blog/2012/08/01/testing-simpleform-inputs/
module InputExampleGroup
  extend ActiveSupport::Concern

  include RSpec::Rails::HelperExampleGroup

  def input_for(object, attribute_name, options={})
    helper.simple_form_for object, url: '' do |f|
      f.input attribute_name, options
    end
  end
end

RSpec.configure do |config|
  config.include InputExampleGroup, type: :input, example_group: {
    file_path: config.escaped_path(%w[spec inputs])
  }
end