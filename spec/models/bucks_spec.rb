require 'spec_helper'

describe Bucks do
  specify { Bucks.should < Asset }

  # Relations
  it { should be_embedded_in :proposal}

  # Fields

  it { should have_field(:_money).of_type(Money)}
end
