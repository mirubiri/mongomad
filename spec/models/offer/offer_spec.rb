require 'spec_helper'

describe Offer do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) do
    Fabricate.build(:offer,
                    user_composer:user_composer,
                    user_receiver:user_receiver )
  end
  let(:offer_params) { params_for_offer(offer) }

  describe 'Relations' do
    it { should embed_one(:composer).of_type(Offer::Composer) }
    it { should embed_one(:receiver).of_type(Offer::Receiver) }
    it { should embed_one(:money).of_type(Offer::Money) }
    it { should belong_to(:user_composer).of_type(User) }
    it { should belong_to(:user_receiver).of_type(User) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:initial_message).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer }
    it { should validate_presence_of :user_receiver }
    it { should validate_presence_of :initial_message }
  end

  describe 'Factories' do
    specify { expect(offer.valid?).to eq true }
    specify { expect(offer.save).to eq true }

    it 'creates two different users' do
      expect { offer.publish }.to change{ User.count }.by(2)
    end
  end

  describe '.generate(offer_params)' do
    it 'generates a valid offer given correct parameters' do
      Offer.generate(offer_params).should be_valid
    end

    it 'returns an offer corresponding to the given params' do
      Offer.generate(offer_params).should be_like offer
    end
  end

  describe '#publish' do
    context 'When offer is valid' do
      it 'returns true' do
        offer.publish.should eq true
      end

      it 'saves the offer' do
        offer.publish
        Offer.all.to_a.should include(offer)
      end

      it 'adds the offer to sent_offers for user_composer' do
        offer.publish
        User.find(offer.user_composer).sent_offers.should include(offer)
      end

      it 'adds the offer to received_offers for user_receiver' do
        offer.publish
        User.find(offer.user_receiver).received_offers.should include(offer)
      end
    end

    context 'When offer is not valid' do
      before { offer.should_receive(:save).and_return(false) }

      it 'returns false' do
        offer.publish.should eq false
      end

      it 'does not save the offer' do
        offer.publish
        Offer.all.to_a.should_not include(offer)
      end

      it 'does not add the offer to sent_offers for user_composer' do
        offer.publish
        User.find(offer.user_composer).sent_offers.should_not include(offer)
      end

      it 'does not add the offer to received_offers for user_receiver' do
        offer.publish
        User.find(offer.user_receiver).received_offers.should_not include(offer)
      end
    end

    context 'When offer is published' do
      before { offer.publish }

      it 'returns true' do
        offer.publish.should eq true
      end

      it 'do not create a new offer' do
        expect { offer.publish }.to_not change { Offer.count }
      end
    end
  end

  describe '#unpublish' do
    before do
      offer.publish
      offer.unpublish
    end

    context 'When offer is saved' do
      it 'returns true' do
        offer.unpublish.should eq true
      end

      it 'removes the offer' do
        Offer.all.to_a.should_not include(offer)
      end

      it 'removes the offer from sent_offers for user_composer' do
        offer.user_composer.reload.sent_offers.should_not include(offer)
      end

      it 'removes the offer from received_offers for user_receiver' do
        offer.user_receiver.reload.received_offers.should_not include(offer)
      end

      it 'does not remove composer image' do
        offer.composer.image.file.should be_exists
      end

      it 'does not remove receiver image' do
        offer.receiver.image.file.should be_exists
      end

      it 'does not remove product images from receiver' do
        offer.receiver.products.each do |product|
          product.image.file.should be_exists
        end
      end

      it 'does not remove product images from composer' do
        offer.composer.products.each do |product|
          product.image.file.should be_exists
        end
      end
    end

    context 'When offer is not saved' do
      it 'returns true' do
        offer.unpublish.should eq true
      end
    end
  end

  describe '#alter_contents(params)' do
    after { offer.alter_contents(offer_params) }

    it 'calls to composer.alter_contents with params[:composer_things]' do
      offer.composer.should_receive(:alter_contents).with(offer_params[:composer_things])
    end

    it 'calls to receiver.alter_contents with params[:receiver_things]' do
      offer.receiver.should_receive(:alter_contents).with(offer_params[:receiver_things])
    end

    it 'calls to money.alter with params[:money]' do
      offer.money.should_receive(:alter_contents).with(offer_params[:money])
    end

    it 'changes initial_message with value of params[:initial_message]' do
      offer.should_receive(:initial_message).with(offer_params[:initial_message])
    end

    specify { expect(offer.alter_contents(offer_params)).to eq true }
  end

  describe '#self_update' do
    it 'calls reload if persisted' do
      offer.publish
      offer.should_receive(:reload)
      offer.self_update
    end

    it 'does not call reload if not persisted' do
      offer.should_not_receive(:reload)
      offer.self_update
    end

    it 'calls to offer.composer.self_update' do
      offer.composer.should_receive(:self_update)
      offer.self_update
    end

    it 'calls to offer.receiver.self_update' do
      offer.receiver.should_receive(:self_update)
      offer.self_update
    end

    it 'returns self if self_update success' do
      offer.self_update.should eq offer
    end

    it 'raise error if self_update fails' do
      offer.composer.stub(:self_update).and_raise("StandardError")
      offer.receiver.stub(:self_update).and_raise("StandardError")
      expect { offer.self_update }.to raise_error
    end
  end

  describe '#start_negotiation' do
    xit 'starts a negotiation froom the offer'
  end
end
