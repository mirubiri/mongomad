require 'rspec/expectations'

module MongomadMatchers
  extend RSpec::Matchers::DSL

  define_method :denormalized_fields do |obj|
    all_fields = []
    obj.denormalized_definitions.each do |definition|
      all_fields += definition[:fields]
    end
    all_fields.sort
  end

  define_method :all_froms do |obj|
    froms = []
    obj.denormalized_definitions.each do |definition|
      froms << definition[:options][:from]
    end
    froms.sort
  end

  matcher :have_denormalized_fields do |*fields|
    match do |obj|
      if obj.respond_to? :denormalized_definitions
        ((denormalized_fields(obj) & fields ).sort == fields.sort) &&
        all_froms(obj).include?(@instance)
      else
        false
      end
    end

    failure_message_for_should do |obj|
      "expect that denormalized fields #{denormalized_fields(obj)} include #{fields} and to take data from \"#{@instance}\" included in #{all_froms(obj)}"
    end

    failure_message_for_should_not do |obj|
      "expect that denormalized fields #{denormalized_fields(obj)} not to include #{fields} and to not take data from \"#{@instance}\" not included in #{all_froms(obj)}"
    end

    chain :from do |instance|
      @instance = instance
    end
  end
end