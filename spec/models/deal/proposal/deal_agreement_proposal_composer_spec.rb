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
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(composer).to be_valid }

    it 'Creates one deal' do
      expect { composer.save }.to change{ Deal.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      composer.save
      expect(File.exist? composer.image.path).to eq true
    end
  end
end
