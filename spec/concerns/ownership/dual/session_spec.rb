require 'spec_helper'

class EmptyTestOwnershipSession
end

class TestOwnershipSession
	include Ownership::Dual
	include Ownership::Dual::Session
end

describe 'Ownership::Dual::Session' do
	subject(:klass) { TestOwnershipSession }
	let(:empty_class) { EmptyTestOwnershipSession }

	it 'raise error if Ownership::Dual is not included' do
		expect { empty_class.include Ownership::Dual::Session }.to raise_error
	end

	let(:owner) { Fabricate.build(:user) }
	let(:non_owner) { Fabricate.build(:user) }
  let(:document) do
  	document=klass.new
  	document.register(owner)
  	document.register(Fabricate.build(:user))
  	document
  end

	describe '#login(user)' do

		context 'user is a owner' do
			it 'logs in the user' do
				document.login(owner)
				expect(document.logged_user).to eq owner.id
			end

			it 'returns true' do
				expect(document.login(owner)).to eq true
			end
		end

		context 'user is not a owner' do
			it 'returns false' do
				expect(document.login(non_owner)).to eq false
			end

			it 'does not log in the user_id' do
				document.login(non_owner)
				expect(document.logged_user).to eq nil
			end
		end

		context 'user is currently logged in' do
			it 'returns true' do
				document.login(owner)
				expect(document.login(owner)).to eq true
			end
		end
	end

	describe '#logged_user' do
		it 'returns the logged user' do
			document.login(owner)
			expect(document.logged_user).to eq owner.id
		end

		it 'returns nil if nobody is logged' do
			expect(document.logged_user).to eq nil
		end
	end

	describe '#register(user)' do
		it 'registers a new user as owner' do
			document.user_ids=[]
			document.register(owner)
			expect(document.registered?(owner)).to eq true
		end
	end

	describe '#registered?' do
		it 'returns true if given user is a owner' do
			expect(document.registered? owner).to eq true
		end

		it 'returns false if given user is not a owner' do
			expect(document.registered? non_owner).to eq false
		end
	end
end