require 'spec_helper'

describe Attachment::Images do
  # Variables
  let (:test_class) do
    Struct.new(nil) do
      include Mongoid::Document
      include Attachment::Images
    end
  end

  let(:image_one) { Fabricate.build(:image_product, id:'one', main: true) }
  let(:image_two) { Fabricate.build(:image_product, id:'two') }
  let(:image_three) { Fabricate.build(:image_product, id:'three') }

  let(:image_holder) do
    test = test_class.new
    test.images << image_one
    test.images << image_two
    test.images << image_three
    test
  end

  subject { test_class }

  # Relations
  it { should embed_many :images }

  # Checks
  it 'is invalid when no main image' do
    image_holder.images.update_all(main:false)
    expect(image_holder).to have(1).errors_on(:images)
    expect(image_holder.errors_on(:images)).to include('There is no main image.')
  end

  it 'is invalid when more than one main image' do
    image_holder.images.update_all(main:true)
    expect(image_holder).to have(1).errors_on(:images)
    expect(image_holder.errors_on(:images)).to include('Cannot have more than one main image.')
  end

  # Methods
  describe '#main_image' do
    it 'returns the main image' do
      expect(image_holder.main_image).to eq image_one
    end
  end

  describe '#set_main_image' do
    context 'given an existent image id' do
      it 'unsets the current main image' do
        previous_main = image_holder.main_image
        image_holder.set_main_image(image_two._id)
        expect(previous_main.main).to eq false
      end

      it 'sets the given image to main' do
        image_holder.set_main_image(image_two._id)
        expect(image_holder.main_image).to eq image_two
      end

      it 'returns true' do
        expect(image_holder.set_main_image(image_two._id)).to eq true
      end
    end

    context 'given an inexistent image' do
      let(:inexistent_image) { Fabricate.build(:image_product, id:'inexistent') }

      it 'do not change the main image to the given one' do
        expect{ image_holder.set_main_image(inexistent_image._id) }.to_not change { image_holder.main_image }
      end

      it 'returns false' do
        expect(image_holder.set_main_image(inexistent_image._id)).to eq false
      end
    end
  end
end
