#
# Usage:
#
#     describe Post do
#       it { should delegate(:name).to(:author).with_prefix } # post.author_name
#       it { should delegate(:month).to(:created_at) }
#       it { should delegate(:year).to(:created_at) }
#     end

RSpec::Matchers.define :delegate do |method|
  match do |actual|

    @method = method
    @actual = actual

    @target = actual.send(@to)

    allow(@target).to receive(@method) { :return_value }

    if method.slice('=')
      @actual.send(@method,:value) == :value
    else
      @actual.send(@method) == :return_value
    end
  end

  description do
    "delegate :#{@method} to #{@to}"
  end

  failure_message_for_should do |text|
    "expected #{@actual} to delegate :#{@method} to #{@to}"
  end

  failure_message_for_should_not do |text|
    "expected #{@actual} not to delegate :#{@method} to #{@to}"
  end

  chain :to do |to|
    @to = to
  end
end
