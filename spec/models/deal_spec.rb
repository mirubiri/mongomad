require 'spec_helper'

describe Deal do
  it { should belong_to :deal_box }
  it { should embed_one(:conversation) }
  it { should embed_one :agreement }

  describe 'Factory' do
    let (:deal) { Fabricate(:deal) }
    specify { deal.should be_valid }
  end
end