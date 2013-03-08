require 'spec_helper'

describe Offer::Composer do
  let(:offer) { Fabricate.build(:offer) }
  let(:composer) { offer.composer }
  let(:products_params) { params_for_offer(offer)[:composer_things] }

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(composer.valid?).to eq true }

    it 'creates one offer' do
      expect { composer.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should eq true
    end
  end

  describe '#add_products(products_params)' do
    it 'creates a product from each param passed' do
      new_composer = composer.dup
      new_composer.products.destroy
      new_composer.add_products(products_params)
      new_composer.products.should be_like composer.products
    end

    it 'does not persist the composer' do
      composer.should_not be_persisted
    end

    it 'raise exception if any parameter is not correct' do
      products_params[:composer_things].first = nil
      expect { composer.add_products(products_params) }.to raise_error
    end

    it 'calls to self_update method' do
      composer.should_receive(:self_update!)
      composer.add_products(products_params)
    end

    it 'calls update_user_data method' do
      composer.should_receive(:update_user_data)
      composer.add_products(products_params)
    end

    it 'calls update_products method' do
      composer.should_receive(:update_products)
      composer.add_products(products_params)
    end
  end

  describe '#self_update!' do
    let(:new_composer) do
      new_composer = composer.dup
    end

    it 'returns self it self_update! success' do
      new_composer.self_update!
      new_composer.should be_like composer
    end

    it 'raise error if self_update! fails' do
      new_composer.offer.user_composer = nil
      expect { new_composer.self_update! }.to raise_error
    end

    it 'returns a valid composer' do
      new_composer.self_update!
      new_composer.should be_valid
    end

    it 'updates composer name with the current user_composer name' do
      new_composer.offer.user_composer.profile.stub(:name).and_return('updated')
      new_composer.self_update!
      new_composer.name.should eq 'updated'
    end

    it 'updates composer image_name with the current user_composer image_name' do
      new_composer.offer.user_composer.profile.stub(:image_name).and_return('updated.png')
      new_composer.self_update!
      new_composer.image_name.should eq 'updated.png'
    end

    context 'When composer(offer) is published' do
      before { new_composer.offer.publish }

      it 'calls reload method' do
        new_composer.should_receive(:reload)
        new_composer.self_update!
      end

      it 'save the changes' do
        new_composer.should_receive(:save)
        new_composer.self_update!
      end
    end

    context 'When composer(offer) is not published' do
      it 'does not save the changes' do
        new_composer.should_not_receive(:save)
        new_composer.self_update!
      end
    end
  end

=begin
  it 'calls update_user_data' do
      # Use relationship.target to access to the wrapped object
      composer.target.should_receive(:update_user_data)
      composer.self_update
    end

    it 'calls update_products' do
      composer.target.should_receive(:update_products)
      composer.self_update
    end

    it 'updates composer name with the current user composer name' do
      composer.offer.user_composer.profile.stub(:name).and_return('updated')
      composer.self_update
      composer.name.should eq 'updated'
    end

    it 'updates composer image_name with the current user composer image_name' do
      composer.offer.user_composer.profile.stub(:image_name).and_return('updated.png')
      composer.self_update
      composer.image_name.should eq 'updated.png'
    end

  describe '#alter_contents(params)' do
    after { composer.alter_contents(composer_things_params) }

    it 'removes the current list of products' do
      composer.products.should_receive(:destroy)
    end

    it 'add the given list of products' do
      composer.target.should_receive(:add_products).with(composer_things_params)
    end

    it 'calls to self_update' do
      pending 'pensar si llamarlo o no'
    end
  end

  describe '#update_products' do
    xit 'update the information of all products'
  end
=end
end
