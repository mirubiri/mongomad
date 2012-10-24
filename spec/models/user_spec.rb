require 'spec_helper'

describe User do
  describe 'Embedded' do
    it { should embed_one(:profile) }
    it { should embed_one(:offer_inbox) }
    it { should embed_one(:offer_outbox) }
    it { should embed_one(:thing_box) }
    it { should embed_one(:negotiation_box) }
    it { should embed_one(:deal_box) }
  end

  describe 'Attributes' do
    pending 'Anadir los atributos para usuario'
  end

  describe 'Factory' do
    let (:user) { Fabricate(:user) }
    specify { user.should be_valid }
  end
end
