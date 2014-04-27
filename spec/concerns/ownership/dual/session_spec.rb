require 'spec_helper'

class EmptyTestOwnershipSession
end

class TestOwnershipSession
	include Ownership::Dual
	include Ownership::Dual::Session
end

describe 'Ownership::Dual' do
	subject(:klass) { TestOwnershipSession }
	let(:empty_class) { EmptyTestOwnershipSession }

	it 'raise error if Ownership::Dual is not included' do
		expect { empty_class.include Ownership::Dual::Session }.to raise_error
	end


  let(:document) { klass.new(user_ids:["0","1"]) }
  let(:owner) { 0 }
  let(:non_owner) { 2 }

	describe '#login(user_id)' do

		context 'user_id is a owner' do
			it 'logs in the user' do
				document.login(owner)
				expect(document.logged).to eq owner
			end

			it 'returns true' do
				expect(document.login(owner)).to eq true
			end
		end

		context 'user_id is not a owner' do
			it 'returns false' do
				expect(document.login(non_owner)).to eq false
			end

			it 'does not log in the user_id' do
				document.login(non_owner)
				expect(document.logged).to eq nil
			end
		end

		context 'user_id is currently logged in' do
			it 'returns true' do
				document.login(owner)
				expect(document.login(owner)).to eq true
			end
		end
	end

	describe '#logged' do
		it 'returns the logged user_id' do
			document.login(owner)
			expect(document.logged).to eq owner
		end

		it 'returns nil if nobody is logged' do
			expect(document.logged).to eq nil
		end
	end

	describe '#register(user_id)' do
		it 'registers a new user as owner' do
			document.user_ids=[]
			document.register(owner)
			expect(document.owned_by?(owner)).to eq true
		end
	end

	describe '#owned_by?' do
		it 'returns true if given user_id is a owner' do
			expect(document.owned_by? owner).to eq true
		end

		it 'returns false if given user is not a owner' do
			expect(document.owned_by? non_owner).to eq false
		end
	end
end