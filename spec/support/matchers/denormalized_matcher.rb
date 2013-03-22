
require 'rspec/expectations'

module MongomadMatchers
  extend RSpec::Matchers::DSL

  define_method :denormalized_fields do |obj|
    all_fields=[]
    obj.denormalized_definitions.each do |definition|
      all_fields+=definition[:fields]
    end
    all_fields.sort
  end

  matcher :have_denormalized_fields do |*fields|
    match do |obj|
      if obj.respond_to? :denormalized_definitions
        (denormalized_fields(obj) & fields ) == fields.sort
      else
        false
      end
    end

    failure_message_for_should do |obj|
      "expect that denormalized fields #{denormalized_fields(obj)} include #{fields}"
    end

    failure_message_for_should_not do |obj|
      "expect that denormalized fields #{denormalized_fields(obj)} not to include #{fields}"
    end

  end
end