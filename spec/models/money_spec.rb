require 'spec_helper'

describe Money do
  specify { Money.should < Asset }

  # Relations
  it { should be_embedded_in :proposal}
end
