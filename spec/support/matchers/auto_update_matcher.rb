RSpec::Matchers.define :auto_update do |*fields|
  match do |actual|
  	definitions=actual.auto_update_definitions
    (definitions[:fields] - fields).empty? &&
    definitions[:options][:using] == @source
  end

  failure_message_for_should do |actual|
  	actual_definitions = actual.auto_update_definitions
  	expected_definitions = { fields:fields,options:{using:@source} }
    "expected that #{actual_definitions} to eq #{ expected_definitions}"
  end

  chain :using do |source|
    @source = source
  end
end