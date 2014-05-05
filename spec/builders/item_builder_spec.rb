require 'spec_helper'

describe ItemBuilder do
	let(:builder) { ItemBuilder.new }
	let(:image_ids_array) { [0,1,2] }
	let(:image_id) { '0' }
  let(:description) { 'a description' }
  let(:name) { 'a name' }
  let(:user) { Fabricate.build(:user) }
  let(:user_id) { user.id }
  let(:user_sheet) { user.sheet }

  let(:filled_builder) do
  		builder.user=user
			builder.main_image=image_id
			builder.images=image_ids_array
			builder.name=name
			builder.description=description
			builder
  end

	describe '#images=(array)' do
		context 'no given array' do
			it 'has [] as default value' do
				expect(builder.images).to eq []
			end
		end

		context 'given an array' do
			before(:each) { builder.images=image_ids_array }
			it 'returns the given array' do
				expect(builder.images).to eq image_ids_array
			end
		end
	end

	describe '#main_image=(image_id)' do
		context 'given an image id' do
			before(:each) { builder.main_image=image_id }
			it 'returns the given image_id' do
				expect(builder.main_image).to eq image_id
			end
		end
	end

	describe '#description=(description)' do
		context 'given a description' do
			before(:each) { builder.description=description }
			it 'returns the given description' do
				expect(builder.description).to eq description
			end
		end
	end

	describe '#name=(name)' do
		context 'given an image id' do
			before(:each) { builder.name=name }
			it 'returns the given name' do
				expect(builder.name).to eq name
			end
		end
	end

	describe '#user=(user)' do
		context 'given a user' do
			before(:each) { builder.user=user }
			it 'returns the given user' do
				expect(builder.user).to eq user
			end
		end
	end

	describe '#errors' do
	end

	describe '#create' do
		%w[description name user main_image].each do |field|
			it "returns false if #{field} is not set" do
				filled_builder.send("#{field}=",nil)
				expect(filled_builder.create).to eq false
			end
		end

		it 'do not return false if images is unset' do
			filled_builder.images=[]
			expect(filled_builder.create).to be_true
		end

		describe 'returned offer' do
			let(:item) { filled_builder.create }

			it 'is an Offer' do
				expect(item).to be_a_kind_of(Offer)
			end

			%w[ description name user_id main_image images].each do |field|
				it "has the setted #{field}" do
					expect(item.send(field)).to eq send(field)
				end
			end
		end
	end

end