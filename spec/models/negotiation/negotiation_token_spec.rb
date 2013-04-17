require 'spec_helper'

describe Negotiation::Token do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:token) { negotiation.token }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:state).of_type(Symbol) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :state }
    it { should validate_inclusion_of(:state).to_allow([:propose, :accept]) }
  end

  describe 'Factories' do
    specify { expect(token).to be_valid }

    it 'creates one negotiation' do
      expect { token.save }.to change{ Negotiation.count }.by(1)
    end
  end
end
