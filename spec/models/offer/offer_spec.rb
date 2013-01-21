require 'spec_helper'

describe Offer do
  let(:offer) do
    Fabricate.build(:offer)
  end

  describe 'Relations' do
    it { should embed_one(:composer).of_type(Offer::Composer) }
    it { should embed_one(:receiver).of_type(Offer::Receiver) }
    it { should embed_one(:money).of_type(Offer::Money) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:initial_message).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :users }
    it { should validate_presence_of :initial_message }
    
    specify { offer.users.should have(2).users }
    it 'has two different users' do
     offer.users.uniq.count.should eq offer.users.count
    end 
  end

  describe 'Factories' do
    specify { expect(offer.valid?).to be_true }
    specify { expect(offer.save).to be_true }
  end

  describe '#save' do
     it 'Creates two users' do
      expect { offer.save }.to change{ User.count }.by(2)
     end
  end
end
