require 'spec_helper'

describe Receiver do
  it { should be_embedded_in :offer }
  it { should embed_one :product_box }
end
