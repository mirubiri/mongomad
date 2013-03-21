require 'spec_helper'

describe Offer::Money do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:money) { offer.money }
  let(:money_params) { params_for_offer(offer)[:money] }

  describe 'Relations' do
    it { should be_embedded_in :offer }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(money.valid?).to eq true }

    it 'creates one offer' do
      expect { money.save }.to change{ Offer.count }.by(1)
    end
  end

  describe '#alter_contents(money_params)' do
    let(:new_money) { money.clone }

    it 'modifies only correct parameters when more parameters are given' do
      new_money.user_id = nil
      new_money.quantity = nil
      new_params = {
        user_id:money_params[:user_id],
        quantity:money_params[:quantity],
        another:'another'
      }
      new_money.alter_contents(new_params).should be_like money
    end

    it 'returns an unmodified money when no correct parameter is given' do
      new_params = { another:'another' }
      new_money.alter_contents(new_params).should be_like money
    end

    it 'returns a valid money' do
      money.alter_contents(money_params)
      money.should be_valid
    end

    it 'raises exception if user_id parameter is not correct' do
      user = Fabricate.build(:user)
      new_params = { user_id:user._id }
      user.destroy
      expect { money.alter_contents(new_params) }.to raise_error
    end

    it 'raises exception if quantity parameter is nil' do
      new_params[:quantity] = nil
      expect { money.alter_contents(new_params) }.to raise_error
    end

    it 'raises exception if quantity parameter is negative' do
      new_params[:quantity] = -1
      expect { money.alter_contents(new_params) }.to raise_error
    end

    context 'When offer is published' do
      before { money.offer.publish }

      it 'calls reload method' do
        money.should_receive(:reload)
        money.alter_contents(money_params)
      end

      it 'save changes' do
        money.should_receive(:save)
        money.alter_contents(money_params)
      end
    end

    context 'When offer is not published' do
      it 'does not call reload method' do
        money.should_not_receive(:reload)
        money.alter_contents(money_params)
      end

      it 'does not save changes' do
        money.should_not_receive(:save)
        money.alter_contents(money_params)
      end
    end
  end
end
