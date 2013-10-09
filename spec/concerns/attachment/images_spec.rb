require 'spec_helper'

describe Attachment::Images do

  let (:test_class) do
  	Struct.new(nil) do
  		include Mongoid::Document
  		include Attachment::Images
  	end
  end

  let(:image_one) { Fabricate.build(:image,id:'one',main: true) }
  let(:image_two) { Fabricate.build(:image,id:'two') }
  let(:image_three) { Fabricate.build(:image,id:'three') }

  let(:image_holder) do
    test=test_class.new
    test.images<<image_one
    test.images<<image_two
    test.images<<image_three
  end

# Methods

  describe '#main_image' do
  	it 'returns the main image' do
  		expect(image_holder.main_image).to eq image_one
  	end
  end

  describe '#set_main_image' do

  	context 'given an existent image id' do
  	  it 'changes the main image to the given one' do
        image_holder.set_main_image(image_two.id)
        expect (image_holder.main_image).to eq image_two
  	  end

  	  it 'returns true' do
  	    expect (image_holder.set_main_image(image_two.id)).to eq true
  	  end
    end

    context 'given an inexistent image' do
	  	it 'do not change the main image to the given one' do
        expect { image_holder.main_image('four') }.to_not change { image_holder.main_image }
	  	end

	  	it 'returns false' do
	  		expect (image_holder.set_main_image('four')).to eq false
	  	end
	  end

    context 'given a deleted image' do
      it 'do not change the main image to the given one' do
        image_holder.delete_images( %w(two) )
        expect { image_holder.set_main_image('two') }.to_not change { image_holder.main_image }
      end

      it 'returns false' do
        image_holder.delete_images( %w(two) )
        expect(image_holder.set_main_image( %(two))).to eq false
      end
    end
  end

  describe '#delete_images' do
      it 'mark as deleted the existing given images' do
  	  	expect { image_holder.delete_images( %w(one two six) )}.to change { image_holder.images }.from([image_one,image_two,image_three]).to( [image_three] )
  	  end

  	  it 'returns true' do
  	  	expect (image_holder.delete_images( %w(one two six) )).to eq true
  	  end
  end

  describe '#add_images' do
  	it 'adds given images to the image list' do
      image_ten = Fabricate.build(:image,id:'ten')
  		expect { image_holder.add_image(image_ten)}.to change{image_holder.images}.from( [image_one,image_two,image_three] ).to( [image_one,image_two,image_three,image_ten] )
  	end

  	it 'returns true' do
  		expect(image_holder.add_image( %w(five six) )).to eq true
  	end
  end

  describe '#images' do
  	it 'returns all images' do
  		expect(image_holder.images).to eq image_holder.images
  	end

    it 'do not return deleted images' do
      image_holder.delete_images(image_two)
      expect(image_holder.images).to eq [image_one,image_three]
    end
  end
end