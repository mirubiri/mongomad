require 'spec_helper'

describe Deal::Agreement::Proposal do
  let(:proposal) do
    Fabricate.build(:deal).agreement.proposals.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:agreement).of_type(Deal::Agreement) }
    it { should embed_one(:composer).of_type(Deal::Agreement::Proposal::Composer) }
    it { should embed_one(:receiver).of_type(Deal::Agreement::Proposal::Receiver) }
    it { should embed_one(:money).of_type(Deal::Agreement::Proposal::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_composer_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_receiver_id).of_type(Moped::BSON::ObjectId) }
    it { should accept_nested_attributes_for :composer }
    it { should accept_nested_attributes_for :receiver }
    it { should accept_nested_attributes_for :money }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer_id }
    it { should validate_presence_of :user_receiver_id }
  end

  describe 'Factories' do
    specify { expect(proposal.valid?).to eq true }

    it 'Creates one deal' do
      expect { proposal.save }.to change{ Deal.count }.by(1)
    end
  end
end
