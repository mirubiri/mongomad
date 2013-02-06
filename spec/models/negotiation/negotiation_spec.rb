require 'spec_helper'

describe Negotiation do
  let(:negotiation) do
    Fabricate.build(:negotiation, offer:Fabricate(:offer))
  end

  describe 'Relations' do
    it { should embed_many(:proposals).of_type(Negotiation::Proposal) }
    it { should embed_many(:messages).of_type(Negotiation::Message) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
    it { should validate_presence_of :users }
  end

  describe 'Factories' do
    specify { expect(negotiation.valid?).to be_true, "Is not valid because #{negotiation.errors}" }
    specify { expect(negotiation.save).to be_true }

    it 'Creates one offer' do
      expect { negotiation.save }.to change{ Offer.count }.by(1)
    end

    it 'Creates two different users' do
      expect { negotiation.save }.to change{ User.count }.by(2)
    end
  end

  describe '.open' do
    let(:offer) { Fabricate(:offer) }
    let(:new_negotiation) { Negotiation.open(offer).publish }

    context 'new_negotiation -> users data' do
      specify { new_offer.proposals.last.user_composer_id.should eql offer.user_composer_id }
      specify { new_offer.proposals.last.user_receiver_id.should eql offer.user_receiver_id }
    end

    context 'new_negotiation -> products' do
      it 'Copy all offer products into negotiation products' do
        ['receiver','composer'].each do |person|
          offer_products = offer.send("#{person}").products

          offer_products.size.should eql new_negotiation.proposals.last.send("#{person}").products.size

          offer_products.each do |offer_product|
            product = new_negotiation.proposals.last.send("#{person}").products.where(_id:offer_product._id).first

            ['_id','thing_id','quantity'].each do |field|
              product.send(field).should eq offer_product.send(field)
            end

            ['name','description','image_name'].each do |field|
              product.instance_eval(field).should eq offer_product.instance_eval(field)
            end
          end
        end
      end
    end

    context 'new_negotiation.proposals.last -> money' do
      specify { new_offer.proposals.last.money.user_id.should eql offer.money.user_id }
      specify { new_offer.proposals.last.money.quantity.should eql offer.money.quantity }
    end

    context 'new_negotiation -> initial_message' do
      specify { new_offer.proposals.last.initial_message.should eql offer.initial_message }
    end
  end

  describe '#make_new_proposal(hash)' do
    xit 'Generates a new proposal with the given hash and post it into the negotiation'
  end

  describe '#part(user)' do
    xit 'Makes the given user to leave the negotiation'
    # ¿Podríamos conseguir que se ejecutara siempre desde el current_user sin pasarle ningun parametro?
    # entonces quedaria como #user_part.
  end

  xit 'Un metodo para aceptar la propuesta actual'
  xit 'Un metodo para rechazar la propuesta actual'
  xit 'Un metodo para comprobar el estado de aceptacion de la propuesta actual'
end
