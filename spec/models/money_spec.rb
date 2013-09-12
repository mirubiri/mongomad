require 'spec_helper'

describe Money do
  specify { Money.should < Asset }
end
