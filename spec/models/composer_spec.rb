require 'spec_helper'

describe Composer do
  it { should be_embedded_in :offer }
  it { should embed_one :product_box }
end
