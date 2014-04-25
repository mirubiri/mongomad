require 'spec_helper'

describe Proposal do
  # Variables
  let(:composer) { Fabricate.build(:user) }
  let(:receiver) { Fabricate.build(:user) }
  let(:proposal) { Proposal.new }
  let(:composer_sheet) { composer.sheet }
  let(:receiver_sheet) { receiver.sheet }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :goods }
  it { should_not embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields(:composer_id,:receiver_id) }
  it { should_not respond_to(:goods,:user_sheets) }


  # Methods
  it { should only_set_once(:composer_id).with(:composer_id=) }
  it { should only_set_once(:receiver_id).with(:receiver_id=) }

  let(:filled_proposal) do
    proposal.composer=composer
    proposal.receiver=receiver
    proposal
  end

  describe '#composer_goods' do
    it 'returns composer goods' do
      items=[ Fabricate.build(:item,user_id:composer.id),Fabricate.build(:cash,user_id:composer.id) ]
      goods=items.map { |item| item.to_product }
      filled_proposal.composer_goods=items
      expect(filled_proposal.composer_goods).to eq goods
    end
  end

  describe '#receiver_goods' do
    it 'returns receiver goods' do
      items=[ Fabricate.build(:item,user_id:receiver.id),Fabricate.build(:cash,user_id:receiver.id) ]
      goods=items.map { |item| item.to_product }
      filled_proposal.receiver_goods=items
      expect(filled_proposal.receiver_goods).to eq goods
    end
  end

  # Factories

end
