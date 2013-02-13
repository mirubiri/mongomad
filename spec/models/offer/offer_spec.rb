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
    specify { expect(offer.valid?).to be_true, "Is not valid because #{offer.errors}" }
    specify { expect(offer.save).to be_true }

    it 'Creates two different users' do
      expect { offer.publish }.to change{ User.count }.by(2)
    end
  end

  describe '.generate(hash)' do
    xit 'Creates a new offer with the given hash'
  end

  describe '#publish' do
    xit 'Saves the offer'
  end

  describe '#modify(hash)' do
    xit 'Updates the offer with the given hash'
  end

  describe '#unpublish' do
    xit 'Deletes the offer'
  end

  describe '#start_negotiation' do
    xit 'Starts a new negotiation from the offer'
  end

  describe '#self_update' do
    xit 'Updates itself'
  end

  #TODO: A apartir de aqui los test antiguos, mover a donde corresponda :)
  #      mirar a ver que funciones son privadas y no deben testearse
  #----------------------------------------------------------------------

  describe '.generate' do
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

    it 'throws exception given incorrect parameters' do
      pending 'Choosing what kind of exception to throw'
    end

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
    context 'When offer is salvable' do
      it 'Saves the offer' do
        offer.should_receive(:save).and_return(true)
        offer.publish
      end

      it 'Returns this offer' do
        offer.publish.should eq offer
      end
    end

    context 'When offer is not salvable' do
      before(:each) { offer.composer = nil }

      it 'Doenst save the offer' do
        offer.should_receive(:save).and_return(false)
        offer.publish
      end

      it 'Returns false' do
        offer.publish.should be_false
      end
    end
  end

  describe '#unpublish' do
    it 'removes a offer' do
      offer.publish
      expect { offer.unpublish }.to change {Offer.count}.by(-1)
    end
  end
end
