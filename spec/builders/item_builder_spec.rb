require 'spec_helper'

describe ItemBuilder do
	let(:builder) { ItemBuilder.new }
	let(:main_image) { Fabricate.build(:image,main:true) }
	let(:image) { Fabricate.build(:image) }
	let(:images) do
		image_params=image.attributes.clone
		main_image_params=main_image.attributes.clone
		image_params["id"]=image_params.delete "_id"
		main_image_params["id"]=main_image_params.delete "_id"
		[ image_params.symbolize_keys,main_image_params.symbolize_keys ]
	end

  let(:description) { 'a description' }
  let(:name) { 'a name' }

  let(:user) { Fabricate.build(:user) }
  let(:user_id) { user.id }
  let(:user_sheet) { user.sheet }

  let!(:filled_builder) do
  		builder.user user
			builder.images images
			builder.name name
			builder.description description
			builder
  end

  let(:item) { filled_builder.build }

	describe '#images(images)' do
		it 'returns builder' do
			expect(builder.images(images)).to eq builder
		end
	end

	describe '#description(description)' do
		it 'returns builder' do
			expect(builder.description(description)).to eq builder
		end
	end

	describe '#name(name)' do
		it 'returns builder' do
			expect(builder.description(description)).to eq builder
		end
	end

	describe '#user(user)' do
		it 'returns builder' do
			expect(builder.user(user)).to eq builder
		end
	end

	describe '#reset' do
		specify { expect(filled_builder.reset).to eq true }
	end

	describe '#build' do
		specify { expect(item.name).to eq name }
		specify { expect(item.user).to eq user_sheet }
		specify { expect(item.description).to eq description }
		specify { expect(item.user_id).to eq user_id }
		specify { expect(item.images).to include(image) }
		specify { expect(item.main_image).to eq main_image }

		context 'After reset' do
			let(:new_item) { Item.new }
			before(:each) do
				allow(Item).to receive(:new).and_return(new_item)
				filled_builder.reset
			end
			it 'returns a new item' do
				expect(filled_builder.build).to eq new_item
			end
		end
	end

end
