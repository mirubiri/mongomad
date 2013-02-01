require 'spec_helper'

describe Offer do
  let(:offer) do
    Fabricate.build(:offer)
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




  describe '.generate_from' do

    new_offer = Fabricate(:offer)

    offer_hash = {
      user_composer_id: new_offer.user_composer_id,
      user_receiver_id: new_offer.user_receiver_id,
      composer_things:  new_offer.composer.products.map do |product|
                          { thing:product[:thing_id], quantity:product[:quantity] }
                        end,
      receiver_things:  new_offer.receiver.products.map do |product|
                          { thing:product[:thing_id],quantity: product[:quantity] }
                        end,
      money:            { user: new_offer.money.user_id, quantity: new_offer.money.quantity },
      initial_message:  new_offer.initial_message
    }

    subject { Offer.generate_from(offer_hash) }
    
    its(:user_composer_id) { should eql offer_hash[:user_composer_id] }
    its(:user_receiver_id) { should eql offer_hash[:user_receiver_id] }

    offer_hash[:composer_things].each_index do |index|
      its("composer.products[#{index}].thing_id") { should eql offer_hash[:composer_things][index][:thing_id] }
      its("composer.products[#{index}].quantity") { should eql offer_hash[:composer_things][index][:quantity] }
    end

    offer_hash[:receiver_things].each_index do |index|
      its("receiver.products[#{index}].thing_id") { should eql offer_hash[:receiver_things][index][:thing_id] }
      its("receiver.products[#{index}].quantity") { should eql offer_hash[:receiver_things][index][:quantity] }
    end
  
  end
end
