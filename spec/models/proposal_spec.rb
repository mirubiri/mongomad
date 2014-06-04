require 'rails_helper'

describe Proposal, :type => :model do
  # Variables
  let(:composer) { Fabricate.build(:user) }
  let(:receiver) { Fabricate.build(:user) }
  let(:proposal) { Proposal.new }
  let(:composer_sheet) { composer.sheet }
  let(:receiver_sheet) { receiver.sheet }

  # Relations
  it { is_expected.to be_embedded_in :proposal_container }
  it { is_expected.to embed_many :goods }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_fields(:composer_id,:receiver_id) }


  let(:filled_proposal) do
    proposal.composer_id=composer.id
    proposal.receiver_id=receiver.id
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
