require 'spec_helper'

describe Offer do
  let(:offer) do
    Fabricate.build(:offer)
  end

  let(:offer_hash) do {
    user_composer_id: offer.user_composer_id,
    user_receiver_id: offer.user_receiver_id,
    composer_things:  offer.composer.products.inject({}) do |hash, product|
                        hash.merge({ product[:thing_id] => product[:quantity] })
                      end,
    receiver_things:  offer.receiver.products.inject({}) do |hash, product|
                        hash.merge({ product[:thing_id] => product[:quantity] })
                      end,
    money:            { offer.money.user_id => offer.money.quantity },
    initial_message:  offer.initial_message
    }
  end

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
      offer.user_composer.should_not eq offer.user_receiver
    end
  end




  describe '.generate_from(hash)' do
    let(:generated_offer) do
      offer.save
      Offer.generate_from(offer_hash)
    end

    it { should respond_to(:generate_from).with(1).arguments }

    specify { generated_offer.should be_kind_of(Offer) }

    specify { generated_offer.valid?.should be_true, "Is not valid because #{generated_offer.errors}" }

    specify { generated_offer.save.should be_true }

    it 'Generates an offer with the user_composer_id value from hash' do
      generated_offer.user_composer_id eql offer_hash[:user_composer_id]
    end

    it 'Generates an offer with the user_receiver_id value from hash' do
      generated_offer.user_receiver_id eql offer_hash[:user_receiver_id]
    end

    it 'Generates an offer with the composer products built from the values from hash' do
      generated_offer.composer.products.size eql offer_hash[:composer_things].length
      generated_offer.composer.products.each do |product|
        product.quantity eql offer_hash[:composer_things][product.thing_id.to_sym]
      end
    end

    it 'Generates an offer with the receiver products built from the values from hash' do
      generated_offer.receiver.products.size eql offer_hash[:receiver_things].length
      generated_offer.receiver.products.each do |product|
        product.quantity eql offer_hash[:receiver_things][product.thing_id.to_sym]
      end
    end

    it 'Generates an offer with the money value from hash' do
      generated_offer.money.user_id eql offer_hash[:money].keys.first
      generated_offer.money.quantity eql offer_hash[:money].values.first
    end

    it 'Generates an offer with the initial_message value from hash' do
      generated_offer.initial_message eql offer_hash[:initial_message]
    end

    # Faltan los negados
  end
end
