require 'spec_helper'

describe Offer do
  let(:offer) { Fabricate.build(:offer) }

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

    it 'Creates two different users' do
      expect { offer.publish }.to change{ User.count }.by(2)
    end
  end



  describe '.generate(offer_form_hash)' do
    let(:offer_hash) do
      offer.publish
      {
        user_composer_id: offer.user_composer_id,
        user_receiver_id: offer.user_receiver_id,
        composer_things:  offer.composer.products.map do |product|
          { thing_id: product[:thing_id], quantity: product[:quantity] }
        end,
        receiver_things:  offer.receiver.products.map do |product|
          { thing_id: product[:thing_id], quantity: product[:quantity] }
        end,
        money:            { user_id: offer.money.user_id, quantity: offer.money.quantity },
        initial_message:  offer.initial_message
      }
    end

    it 'generates a valid offer given correct parameters' do
      Offer.generate(offer_hash).should be_valid
    end

    xit 'throws exception given incorrect parameters'

    describe 'returned offer' do
      let(:new_offer) { Offer.generate(offer_hash) }

      specify { new_offer.user_composer_id.should eql offer_hash[:user_composer_id] }
      specify { new_offer.user_receiver_id.should eql offer_hash[:user_receiver_id] }

      specify { new_offer.money.user_id.should eql offer_hash[:money][:user_id] }
      specify { new_offer.money.quantity.should eql offer_hash[:money][:quantity] }

      specify { new_offer.initial_message.should eql offer_hash[:initial_message] }


      it 'Transform all passed things params into products' do
        ['receiver','composer'].each do |person|
          user = User.find(offer_hash[:"user_#{person}_id"])
          selected_things = offer_hash[:"#{person}_things"]

          selected_things.each do |selected_thing|
            product = new_offer.send("#{person}").products.where(thing_id:selected_thing[:thing_id]).first
            thing = user.things.find(selected_thing[:thing_id])

            ['thing_id','quantity'].each do |field|
              product.send(field).should eq selected_thing[field.to_sym]
            end

            ['name','description','image_name'].each do |field|
              product.send(field).should eq thing.send(field)
            end

          end
        end
      end
    end
  end

  describe '#modify(offer_form_hash)' do
    xit 'updates the offer with the given hash'
  end

  describe '#start_negotiation' do
    it 'calls .start_with(offer)' do
      Negotiation.should_receive(:start_with).with(offer)
      offer.start_negotiation
    end

    describe 'returned negotiation' do
      specify { offer.start_negotiation.should be_persisted }
    end
  end

  describe '#self_update' do
    it 'calls reload if persisted' do
      offer.publish
      offer.should_receive(:reload)
      offer.self_update
    end

    it 'do not call reload if not persisted' do
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

  describe '#publish' do

    context 'When offer is valid' do
      it 'saves the offer' do
        offer.publish
        Offer.all.to_a.should include(offer)
      end

      it 'returns true' do
        offer.publish.should eq true
      end

      it 'adds the offer to sent_offers for user_composer' do
        offer.publish
        offer.user_composer.sent_offers.should include(offer)
      end

      it 'adds the offer to received_offers for user_receiver' do
        offer.publish
        offer.user_receiver.received_offers.should include(offer)
      end
    end

    context 'When offer is not valid' do
      before { offer.should_receive(:save).and_return(false) }

      it 'returns false' do
        offer.publish.should eq false
      end

      it 'do not save the offer' do
        offer.publish
        Offer.all.to_a.should_not include(offer)
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
      it 'removes the offer' do
        Offer.all.to_a.should_not include(offer)
      end

      it 'removes the offer from sent_offers for user_composer' do
        offer.user_composer.reload.sent_offers.should_not include(offer)
      end

      it 'removes the offer from received_offers for user_receiver' do
        offer.user_receiver.reload.received_offers.should_not include(offer)
      end

      it 'returns true' do
        offer.unpublish.should eq true
      end
    end

    context 'When offer is not saved' do
      it 'returns true' do
        offer.unpublish.should eq true
      end
    end
  end
end
