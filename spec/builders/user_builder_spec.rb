require 'spec_helper'

describe UserBuilder do

	let(:builder) { UserBuilder.new }
	let(:filled_builder) do
		builder.first_name('first_name')
			.last_name('last_name')
			.gender(:male)
			.language(:spanish)
			.birth_date('15/10/1981')
			.location([1,2])
			.email('an@email.es')
			.nick('nick')
			.password('password')
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

	describe '#build' do
		specify { expect(user.first_name).to eq 'first_name'}
		specify { expect(user.last_name).to eq 'last_name' }
		specify { expect(user.emal).to eq 'an@email.es' }
		specify { expect(user.password).to eq 'password' }
		specify { expect(user.nick).to eq 'nick' }
		specify { expect(user.location).to eq [1,2] }
		specify { expect(user.birth_date).to eq '15/10/1981'}
		specify { expect(user.gender).to eq :male }
		specify { expect(user.disabled).to eq false }
	end
end