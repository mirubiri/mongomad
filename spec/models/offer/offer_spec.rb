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
      offer.user_composer.should_not eq offer.user_receiver
    end
  end

  describe '.generate' do

    saved_offer=Fabricate(:offer)
    offer_hash =
      {
        user_composer_id: saved_offer.user_composer_id,
        user_receiver_id: saved_offer.user_receiver_id,
        composer_things:  saved_offer.composer.products.map do |product|
                            { thing_id: product[:thing_id], quantity: product[:quantity] }
                          end,
        receiver_things:  saved_offer.receiver.products.map do |product|
                            { thing_id: product[:thing_id], quantity: product[:quantity] }
                          end,
        money:            { user_id: saved_offer.money.user_id, quantity: saved_offer.money.quantity },
        initial_message:  saved_offer.initial_message
      }

    subject(:new_offer) { Offer.generate(offer_hash) }

    its(:user_composer_id) { should eql offer_hash[:user_composer_id] }
    its(:user_receiver_id) { should eql offer_hash[:user_receiver_id] }


    ['composer','receiver'].each do |person|
      offer_hash[:"#{person}_things"].each_index do |index|
        its("#{person}.products[#{index}].thing_id") { should eql offer_hash[:"#{person}_things"][index][:thing_id] }
        its("#{person}.products[#{index}].quantity") { should eql offer_hash[:"#{person}_things"][index][:quantity] }
        its("#{person}.products[#{index}].name") { should eql offer_hash[:"#{person}_things"][index][:name] }
        its("#{person}.products[#{index}].description") { should eql offer_hash[:"#{person}_things"][index][:description] }
      end
    end

    its("initial_message") { should eql offer_hash[:initial_message] }
    its("money.user_id") { should eql offer_hash[:money][:user_id] }
    its("money.quantity") { should eql offer_hash[:money][:quantity] }

  end
end
