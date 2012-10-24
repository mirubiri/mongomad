require 'spec_helper'

describe Agreement do
  it { should be_embedded_in :deal }
end
