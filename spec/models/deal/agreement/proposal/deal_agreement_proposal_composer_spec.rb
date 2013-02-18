require 'spec_helper'

describe Deal::Agreement::Proposal::Composer do
  let(:composer) do
    Fabricate.build(:deal).agreement.proposals.last.composer
  end

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:products).of_type(Deal::Agreement::Proposal::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
    it { should accept_nested_attributes_for :products }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(composer.valid?).to eq true }

    it 'Creates one deal' do
      expect { composer.save }.to change{ Deal.count }.by(1)
    end
  end

  describe 'On save' do
    it 'Has an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should eq true
    end
  end
end
