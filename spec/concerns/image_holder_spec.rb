require 'spec_helper'

describe 'ImageHolder' do

  let (:test_class) do
  	Struct.new(nil) do
  		include Mongoid::Document
  		include ImageHolder
  	end
  end

  subject(:image_holder) { test_class.new(attachments:{main_image:'one', images:['one','two','three'], deleted_images:['four'] }) }


# Methods

  describe '#main_image' do
  	it 'returns the main image' do
  		expect(image_holder.main_image).to eq 'one'
  	end
  end

  describe '#set_main_image' do

  	context 'given an existent image' do
  	  it 'changes the main image to the given one' do
  		  expect { image_holder.main_image('two') }.to change { image_holder.main_image }.from('one').to('two')
  	  end

  	  it 'returns true' do
  	    expect (image_holder.main_image('two')).to eq true
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
  end

  describe '#delete_image' do
  	context 'given an existent image' do
  	  it 'removes the image from the image list' do
  	  	expect { image_holder.delete_image('two') }.to change {image_holder.images }.from(['one','two','three']).to(['one','three'])
  	  end

  	  it 'puts the image into deleted images' do
        expect { image_holder.delete_image('two')}.to change {image_holder.deleted_images}.from(['four']).to(['four','two'])
  	  end

  	  it 'if main image is given it sets the first image in the image list as main image' do
  	  	expect { image_holder.delete_image('one')}.to change {image_holder.main_image}.from('one').to('two')
  	  end

  	  it 'returns true' do
  	  	expect (image_holder.delete_image('two')).to eq true
  	  end
  	end

  	context 'given an inexistent image' do
  		it 'do not delete any image' do
  			expect{image_holder.delete_image('four')}.to_not change {image_holder.images}
  		end

  		it 'do not changes the main image' do
  			expect{ image_holder.delete_image('four')}.to_not change { image_holder.main_image }
  		end

  		it 'returns false' do
  			expect(image_holder.delete_image('four')).to eq false
  		end
  	end
  end

  describe '#add_image' do
  	it 'adds an image to the image list' do
  		expect { image_holder.add_image('five')}.to change{image_holder.images}.from(['one','two','three']).to(['one','two','three','five'])
  	end

  	it 'returns true' do
  		expect(image_holder.add_image('five')).to eq true
  	end
  end

  describe '#add_main_image' do
  	it 'calls to add_image' do
  	  expect(image_holder).to receive(:add_image).with('five')
  	  image_holder.add_main_image('five')
  	end

  	it 'calls to set_main_image' do
  		expect(image_holder).to receive(:set_main_image).with('five')
  		image_holder.add_main_image('five')
  	end

  	it 'returns true' do
  		expect(image_holder.add_main_image('five')).to eq true
  	end

  end

  describe '#images' do
  	it 'returns all images' do
  		expect(image_holder.images).to eq image_holder.attachments[:images]
  	end
  end

  describe '#secondary_images' do
  	it 'returns all images but main image' do
  	  expect(image_holder.secondary_images).to eq image_holder.attachments[:images]-['one']
  	end
  end
end