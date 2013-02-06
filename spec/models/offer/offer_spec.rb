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
      expect { offer.save }.to change{ User.count }.by(2)
    end
  end

  describe '.generate' do
    let(:offer_hash) do
      offer.save
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

    let(:new_offer) { Offer.generate(offer_hash).publish }

    context 'new_offer -> users data' do
      specify { new_offer.user_composer_id.should eql offer_hash[:user_composer_id] }
      specify { new_offer.user_receiver_id.should eql offer_hash[:user_receiver_id] }
    end

    context 'new_offer -> products' do
      it 'Transform all passed things into products' do
        ['receiver','composer'].each do |person|
          user = User.find(offer_hash[:"user_#{person}_id"])
          selected_things = offer_hash[:"#{person}_things"]

          selected_things.each do |selected_thing|
            product = new_offer.send("#{person}").products.where(thing_id:selected_thing[:thing_id]).first
            thing = user.things.find(selected_thing[:thing_id])

            ['thing_id','quantity'].each do |field|
              selected_thing[:"#{field}"].should eq product.send(field)
            end

            ['name','description','attributes["image"]'].each do |field|
              product.instance_eval(field).should eq thing.instance_eval(field)
            end
          end
        end
      end
    end

    context 'new_offer -> money' do
      specify { new_offer.money.user_id.should eql offer_hash[:money][:user_id] }
      specify { new_offer.money.quantity.should eql offer_hash[:money][:quantity] }
    end

    context 'new_offer -> initial_message' do
      specify { new_offer.initial_message.should eql offer_hash[:initial_message] }
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

      it 'Dont saves the offer' do
        offer.should_receive(:save).and_return(false)
        offer.publish
      end

      it 'Returns false' do
        offer.publish.should be_false
      end
    end
  end

  describe '#auto_update' do
    it 'calls reload if persisted' do
      offer.save
      offer.should_receive(:reload)
      offer.auto_update
    end

    it 'do not call reload if not persisted' do
      offer.should_not_receive(:reload)
      offer.auto_update
    end

    it 'calls to offer.composer.auto_update' do
      offer.composer.should_receive(:auto_update)
      offer.auto_update
    end
    it 'calls to offer.receiver.auto_update' do
      offer.receiver.should_receive(:auto_update)
      offer.auto_update
    end
    it 'returns self if auto_update success' do
      offer.auto_update.should eq offer
    end

    it 'raise error if auto_update fails' do
      offer.composer.stub(:auto_update).and_raise("StandardError")
      offer.receiver.stub(:auto_update).and_raise("StandardError")
      expect { offer.auto_update }.to raise_error 
    end
  end
end
