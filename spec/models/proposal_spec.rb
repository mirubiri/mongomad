require 'spec_helper'

describe Proposal do
  let(:proposal) { Fabricate.build(:proposal) }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :goods }
  it { should embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }

  # Validations
  it { should_not validate_presence_of :proposal_container }
  it { should validate_presence_of :composer_id }
  it { should validate_presence_of :receiver_id }

  it 'is invalid when there is not a good for composer' do
    composer_id=proposal.composer_id
    proposal.goods.delete_all(owner_id:composer_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when there is not a good for receiver' do
    receiver_id=proposal.receiver_id
    proposal.goods.delete_all(owner_id:receiver_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid if a good is not owned by composer or receiver' do
    proposal.goods<<Fabricate.build(:product)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid if a good is duplicated' do
    good=proposal.goods.sample
    proposal.goods << good
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when is more than one cash in goods' do
    proposal.goods<<Fabricate.build(:cash,owner_id:proposal.composer_id)
    proposal.goods<<Fabricate.build(:cash,owner_id:proposal.receiver_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when there is not a sheet for composer_id' do
    proposal.composer_id=nil
    expect(proposal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid when there is not a sheet for receiver_id' do
    proposal.receiver_id=nil
    expect(proposal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there are more than two user sheets' do
    proposal.user_sheets << Fabricate.build(:user_sheet)
    expect(proposal).to have(1).error_on(:user_sheets)
  end


  #Methods
  describe 'left(user:id)' do
    it 'returns products for the left side' do
      owner_id = proposal.goods.sample.owner_id
      expect(proposal.goods).to receive(:where).with(owner_id:owner_id)
      proposal.left(owner_id)
    end
  end

  describe 'right(user:id)' do
    it 'return products for the right side' do
      owner_id = proposal.goods.sample.owner_id
      expect(proposal.goods).to receive(:where).with(:owner_id.ne =>owner_id)
      proposal.right(owner_id)
    end
  end

  describe '#cash?' do
    it 'calls goods.type(Cash) with any' do
      expect(proposal.goods.type(Cash)).to receive(:exists?)
      proposal.cash?
    end

    it 'returns true if cash in proposal' do
      proposal.goods.build({},Cash)
      expect(proposal.cash?).to eq true
    end

    it 'returns false if no cash in proposal' do
      expect(proposal.cash?).to eq false
    end
  end

  # Factories
  specify { expect(Fabricate.build(:proposal)).to be_valid }
end
