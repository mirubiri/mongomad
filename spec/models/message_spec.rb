require 'spec_helper'

describe Message do
  it { should be_embedded_in :conversation }
end
