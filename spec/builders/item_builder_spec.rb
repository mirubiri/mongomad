require 'spec_helper'

describe ItemBuilder do
	let(:builder) { ItemBuilder }
	let(:images ) { [Fabricate.build(:image),Fabricate.build(:image,main:true)] }
	let(:image_id) { images.first.id }
  let(:description) { 'a description' }
  let(:name) { 'a name' }
  let(:user) { Fabricate.build(:user) }
  let(:user_id) { user.id }
  let(:user_sheet) { user.sheet }

  let(:filled_builder) do
  		builder.user=user
			builder.main_image=image_id
			builder.images=images
			builder.name=name
			builder.description=description
			builder
  end

	describe '.images(array)' do
		context 'no given array' do
			it 'has [] as default value' do
				expect(builder.images).to eq []
			end
		end

		context 'given an array' do
			before(:each) { builder.images=images }
			it 'returns the given array' do
				expect(builder.images).to eq images
			end
		end
	end

	describe '.main_image(image_id)' do
		context 'given an image id' do
			before(:each) { builder.main_image=image_id }
			it 'returns the given image_id' do
				expect(builder.main_image).to eq image_id
			end
		end
	end

	describe '.description(description)' do
		context 'given a description' do
			before(:each) { builder.description=description }
			it 'returns the given description' do
				expect(builder.description).to eq description
			end
		end
	end

	describe '.name(name)' do
		context 'given an image id' do
			before(:each) { builder.name=name }
			it 'returns the given name' do
				expect(builder.name).to eq name
			end
		end
	end

	describe '.user(user)' do
		context 'given a user' do
			before(:each) { builder.user=user }
			it 'returns the given user' do
				expect(builder.user).to eq user
			end
		end
	end

	describe '#build' do
	end

end