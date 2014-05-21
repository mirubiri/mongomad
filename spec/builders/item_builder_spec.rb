require 'spec_helper'

describe ItemBuilder do
	let(:builder) { ItemBuilder.new }
	let(:main_image) { Fabricate.build(:image,main:true) }
	let(:image) { Fabricate.build(:image) }
	let(:images) { [ image.attributes.symbolize_keys,main_image.attributes.symbolize_keys ] }

  let(:description) { 'a description' }
  let(:name) { 'a name' }

  let(:user) { Fabricate.build(:user) }
  let(:user_id) { user.id }
  let(:user_sheet) { user.sheet }

  let(:filled_builder) do
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

	describe '#build' do
		specify { expect(item.name).to eq name }
		specify { expect(item.user).to eq user_sheet }
		specify { expect(item.description).to eq description }
		specify { expect(item.user_id).to eq user_id }
		specify { expect(item.images).to include(image) }
		specify { expect(item.main_image).to eq main_image }
	end

end