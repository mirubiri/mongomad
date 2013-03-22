require 'spec_helper'

describe Offer do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:offer_params) { params_for_offer(offer) }

  describe 'Relations' do
    it { should belong_to(:user_composer).of_type(User) }
    it { should belong_to(:user_receiver).of_type(User) }
    it { should embed_one(:composer).of_type(Offer::Composer) }
    it { should embed_one(:receiver).of_type(Offer::Receiver) }
    it { should embed_one(:money).of_type(Offer::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:initial_message).of_type(String) }
    it { should accept_nested_attributes_for(:composer) }
    it { should accept_nested_attributes_for(:receiver) }
    it { should accept_nested_attributes_for(:money) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user_composer }
    it { should validate_presence_of :user_receiver }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :initial_message }
    it { should validate_length_of(:initial_message).within(1..160) }
  end

  describe 'Factories' do
    specify { expect(offer.valid?).to eq true }
    specify { expect(offer.save).to eq true }

    it 'creates two different users' do
      expect { offer.save }.to change{ User.count }.by(2)
    end
  end

=begin
  describe '.generate(offer_params)' do
    let(:new_offer) { Offer.generate(offer_params) }

    it 'generates an offer with correct value for given parameters' do
      new_offer.user_receiver_id.should eq offer.user_receiver_id
      ['composer', 'receiver'].each do |user|
        new_offer.send(user).products.should be_like offer.send(user).products
      end
      new_offer.money.should be_like offer.money
      new_offer.initial_message.should eq offer.initial_message
    end

    it 'generates an offer with nil value for not given parameters' do
      new_offer.user_composer_id.should eq nil
    end

    it 'calls to composer.add_products method with offer_params[:composer_things]' do
      offer.composer.should_receive(:add_products).with(offer_params[:composer_things])
      Offer.generate(offer_params)
    end

    it 'calls to receiver.add_products method with offer_params[:receiver_things]' do
      offer.receiver.should_receive(:add_products).with(offer_params[:receiver_things])
      Offer.generate(offer_params)
    end

    it 'does not persist the offer' do
      new_offer.should_not be_persisted
    end

    it 'raises exception if user_receiver_id parameter is nil' do
      offer_params[:user_receiver_id] = nil
      expect { Offer.generate(offer_params) }.to raise_error
    end

    it 'raises exception if user_receiver_id parameter is not correct' do
      user = Fabricate.build(:user)
      offer_params[:user_receiver_id] = user.id
      user.destroy
      expect { Offer.generate(offer_params) }.to raise_error
    end

    it 'raises exception if initial_message parameter is nil' do
      offer_params[:initial_message] = nil
      expect { Offer.generate(offer_params) }.to raise_error
    end

    it 'raises exception if initial_message parameter is empty' do
      offer_params[:initial_message] = ''
      expect { Offer.generate(offer_params) }.to raise_error
    end
  end

  describe '#publish' do
    it 'publish a new offer' do
      offer.should_receive(:save)
      offer.publish
    end

    it 'raises exception if offer is currently published' do
      offer.publish
      expect { offer.publish }.to raise_error
    end
  end

  describe '#unpublish' do
    it 'removes a published offer' do
      offer.publish
      offer.should_receive(:destroy)
      offer.unpublish
    end

    it 'raises exception if offer is currently unpublished' do
      expect { offer.unpublish }.to raise_error
    end
  end

  describe '#alter_contents(offer_params)' do
    let(:new_offer) { offer.clone }

    it 'modifies only correct parameters when more parameters are given' do
      new_offer.user_receiver_id = nil
      new_offer.initial_message = nil
      new_params = {
        user_receiver_id:offer_params[:user_receiver_id],
        initial_message:offer_params[:initial_message],
        another:'another'
      }
      new_offer.alter_contents(new_params).should be_like offer
    end

    it 'returns an unmodified offer when no correct parameters are given' do
      new_params = { another:'another' }
      new_offer.alter_contents(new_params).should be_like offer
    end

    it 'calls to composer.alter_contents method with offer_params[:composer_things]' do
      offer.composer.should_receive(:alter_contents).with(offer_params[:composer_things])
      offer.alter_contents(offer_params)
    end

    it 'calls to receiver.alter_contents method with offer_params[:receiver_things]' do
      offer.receiver.should_receive(:alter_contents).with(offer_params[:receiver_things])
      offer.alter_contents(offer_params)
    end

    it 'calls to money.alter_contents method with offer_params[:money]' do
      offer.money.should_receive(:alter_contents).with(offer_params[:money])
      offer.alter_contents(offer_params)
    end

    it 'raises exception if user_receiver_id parameter is nil' do
      new_params = { user_receiver_id:nil }
      expect { offer.alter_contents(new_params) }.to raise_error
    end

    it 'raise exception if user_receiver_id parameter is not correct' do
      user = Fabricate.build(:user)
      new_params = { user_receiver_id:user._id }
      user.destroy
      expect { offer.alter_contents(new_params) }.to raise_error
    end

    it 'raise exception if initial_message parameter is nil' do
      new_params = { initial_message:nil }
      expect { offer.alter_contents(new_params) }.to raise_error
    end

    it 'raise exception if initial_message parameter is empty' do
      new_params = { initial_message:'' }
      expect { offer.alter_contents(new_params) }.to raise_error
    end

    context 'When offer is published' do
      it 'save the changes' do
        offer.publish
        offer.should_receive(:save)
        offer.alter_contents(offer_params)
      end
    end

    context 'When offer is not published' do
      it 'does not save the changes' do
        offer.should_not_receive(:save)
        offer.alter_contents(offer_params)
      end
    end
  end

  describe '#self_update!' do
    it 'calls to composer.self_update! method' do
      offer.composer.should_receive(:self_update!)
      offer.self_update!
    end

    it 'calls to receiver.self_update! method' do
      offer.receiver.should_receive(:self_update!)
      offer.self_update!
    end

    it 'returns a valid offer' do
      offer.self_update!
      offer.should be_valid
    end

    it 'returns self if self_update! success' do
      new_offer = Request.generate(offer_params)
      new_offer.user = offer.user
      new_offer.self_update!
      new_offer.should be_like offer
    end

    it 'raises exception if self_update! fails' do
      offer.stub(:self_update!).and_raise("StandardError")
      expect { offer.self_update! }.to raise_error
    end

    context 'When offer is published' do
      before do
        new_offer = Fabricate.build(:offer)
        new_params = params_for_offer(new_offer)
        offer.publish
        offer.alter_contents(new_params)
        offer.user = new_offer.user
      end

      it 'calls reload method' do
        offer.should_receive(:reload)
        offer.self_update!
      end

      it 'saves changes' do
        offer.should_receive(:save)
        offer.self_update!
      end
    end

    context 'When offer is not published' do
      before do
        new_offer = Fabricate.build(:offer)
        new_params = params_for_offer(new_offer)
        offer.alter_contents(new_params)
        offer.user = new_offer.user
      end

      it 'does not call reload method' do
        offer.should_not_receive(:reload)
        offer.self_update!
      end

      it 'does not save changes' do
        offer.should_not_receive(:save)
        offer.self_update!
      end
    end
  end

  describe '#start_negotiation' do
    xit 'starts a negotiation from the current offer'
  end
=end
end
