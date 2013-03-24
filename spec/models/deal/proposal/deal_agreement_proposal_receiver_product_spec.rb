require 'spec_helper'

describe Deal::Agreement::Proposal::Receiver::Product do
  let(:product) do
    Fabricate.build(:deal).agreement.proposals.last.receiver.products.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:receiver).of_type(Deal::Agreement::Proposal::Receiver) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :image_name }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(product).to be_valid }

    it 'Creates one deal' do
      expect { product.save }.to change{ Deal.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      product.save
      expect(File.exist? product.image.path)).to eq true
    end
  end
end
