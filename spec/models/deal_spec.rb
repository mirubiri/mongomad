require 'rails_helper'

describe Deal do

  let(:deal) { Fabricate(:deal) }
  let(:composer_id) { deal.composer.id }
  let(:receiver_id) { deal.receiver.id }
  let(:message) { Fabricate.build(:message,id:composer_id) }

  it { is_expected.to include_module Proposable }
  it { is_expected.to include_module Conversation }

  # Relations
  it { is_expected.to embed_many :proposals }
  it { is_expected.to embed_many :messages }

  # Attributes
  it { is_expected.to be_timestamped_document }

  describe '#post_message(message)' do
    let!(:message_poster) { MessagePoster.new(deal) }
    
    it 'calls MessagePoster#post_message' do
      allow(MessagePoster).to receive(:new) { message_poster }
      expect(message_poster).to receive(:post_message).with(message)
      deal.post_message(message)
    end
  end

  describe '#authorized?(user)' do
    let!(:authorized_policy ) { AuthorizedDealPolicy.new(deal) }
    
    it 'calls AuthorizedDealPolicy#authorized?' do
      allow(AuthorizedDealPolicy).to receive(:new) { authorized_policy }
      expect(authorized_policy).to receive(:authorized?).with(composer_id)
      deal.authorized? composer_id
    end
  end

  describe '#participant?' do
    it 'returns false if given user_id is not participating in the deal' do
      expect(deal.participant? composer_id).to eq true
    end

    it 'returns true if given user_id is participating in the deal' do
      expect(deal.participant? 'non_participant').to eq false
    end
  end
end
