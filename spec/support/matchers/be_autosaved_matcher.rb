RSpec::Matchers.define :have_autosave_on do |relation|
  match do |actual|
    actual.autosaved_relations.include?(relation) == true
  end
end