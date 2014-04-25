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
		expect { emty_class.include Ownership::Dual::Session }.to raise_error
	end


  let(:document) { klass.new(user_ids:["0","1"]) }
  let(:participant) { 0 }
  let(:non_participant) { 2 }

	describe '#login(user_id)' do

		context 'user_id is a participant' do
			it 'logs in the user' do
				document.login(participant)
				expect(document.logged).to eq participant
			end

			it 'returns true' do
				expect(document.login(participant)).to eq true
			end
		end

		context 'user_id is not a participant' do
			it 'returns false' do
				expect(document.login(non_participant)).to eq false
			end

			it 'does not log in the user_id' do
				document.login(non_participant)
				expect(document.logged).to eq nil
			end
		end

		context 'user_id is currently logged in' do
			it 'returns true' do
				document.login(participant)
				expect(document.login(participant)).to eq true
			end
		end
	end

	describe '#logged' do
		it 'returns the logged user_id' do
			document.login(participant)
			expect(document.logged).to eq participant
		end

		it 'returns nil if nobody is logged' do
			expect(document.logged).to eq nil
		end
	end

	describe '#participant?' do
		it 'returns true if given user_id is a participant' do
			expect(document.participant? participant).to eq true
		end

		it 'returns false if given user is not a participant' do
			expect(document.participant? non_participant).to eq false
		end
	end
end