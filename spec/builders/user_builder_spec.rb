require 'spec_helper'

describe UserBuilder do

	let(:builder) { UserBuilder.new }
	let(:first_name) { 'first_name'}
	let(:last_name) {'last_name'}
	let(:gender) { :male }
	let(:language) { 'spanish' }
	let(:birth_date) {Date.parse '15/10/1981'}
	let(:location) { [1,2] }
	let(:email) { 'example@server.com' }
	let(:nick) { 'nick' }
	let(:password) { 'password' }

	let(:image) { Fabricate.build(:image,main:true) }
	let(:image_attributes) do
		image_params=image.attributes.clone
		image_params["id"]=image_params.delete "_id"
		[image_params.symbolize_keys]
	end

	let!(:filled_builder) do
		builder.first_name(first_name)
			.last_name(last_name)
			.gender(gender)
			.language(language)
			.birth_date(birth_date)
			.location(location)
			.email(email)
			.nick(nick)
			.password(password)
			.images(image_attributes)
	end

	let(:user) { filled_builder.build }

	describe '#first_name' do
		specify { expect(builder.first_name first_name ).to eq builder }
	end

	describe '#last_name' do
		specify { expect(builder.last_name last_name ).to eq builder }
	end

	describe '#gender' do
		specify { expect(builder.gender gender ).to eq builder }
	end

	describe '#language' do
		specify { expect(builder.language language ).to eq builder }
	end

	describe '#birth_date' do
		specify { expect(builder.birth_date birth_date ).to eq builder }
	end

	describe '#location' do
		specify { expect(builder.location location ).to eq builder }
	end

	describe '#email' do
		specify { expect(builder.email email ).to eq builder }
	end

	describe '#nick' do
		specify { expect(builder.nick nick ).to eq builder }
	end

	describe '#password' do
		specify { expect(builder.password password ).to eq builder }
	end

	describe '#images(image)' do
		specify { expect(builder.images image_attributes).to eq builder }
	end

	describe '#reset' do
		specify { expect(filled_builder.reset).to eq true}
	end

	describe '#build' do
		specify { expect(user.first_name).to eq first_name}
		specify { expect(user.last_name).to eq last_name }
		specify { expect(user.email).to eq email }
		specify { expect(user.password).to eq password }
		specify { expect(user.nick).to eq nick }
		specify { expect(user.location).to eq location }
		specify { expect(user.birth_date).to eq birth_date}
		specify { expect(user.gender).to eq gender }
		specify { expect(user.disabled).to eq false }
		specify { expect(user.images).to include image }

		context 'After reset' do
			let(:new_user) { User.new }
			before(:each) do
				allow(User).to receive(:new).and_return(new_user)
				filled_builder.reset
			end
			it 'returns a new item' do
				expect(filled_builder.build).to eq new_user
			end
		end
	end
end
