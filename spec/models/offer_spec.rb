require 'spec_helper'

describe Offer do
  describe 'Associated models' do
    it { should belong_to :offer_inbox }
    it { should belong_to :offer_outbox }
  end

  describe 'Embedded' do
    it { should embed_one :money }
    it { should embed_one :composer }
    it { should embed_one :receiver }
  end

  describe 'Attributes' do
  end

  describe 'Validations' do
    it { should validate_presence_of(:offer_inbox) }
    it { should validate_presence_of(:offer_outbox) }
    it { should validate_presence_of(:composer) }
    it { should validate_presence_of(:receiver) }
  end

  describe 'Factory' do
    let (:offer) { Fabricate(:offer) }
    specify { offer.should be_valid }
  end
end
