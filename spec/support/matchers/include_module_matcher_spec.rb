RSpec::Matchers.define :include_module do |expected|
  match do |actual|
    actual.class.included_modules.include? expected
  end
end