require 'spec_helper'

class Test::ProposalManager
  include Mongoid::Document
  include ProposalManager

  manage_proposal :_proposal

  embeds_one :_proposal
end

describe 'ProposalManager' do
	let(:proposal_container_class) { Test::ProposalManager }
	let(:proposal) { Fabricate(:proposal) }
	let(:product) { proposal.goods(type:Product).first }
	let(:item) { Item.find(product.id) }

	subject(:document) do
		document=proposal_container_class.new
		document._proposal=proposal
		document
	end

	describe '#withdraw(item)' do
	end

	describe '#update(item)' do
	end

	describe '#fulfillable?' do
	end

	describe '#composer' do
	end

	describe '#receiver' do
	end

	describe '#wanted_goods' do
	end

	describe '#offered_goods' do
	end

	describe '#propose(wanted:[],offered:[])' do

		context 'cash exist in wanted and offered' do
			xit 'returns false'
		end

		context 'wanted is empty' do
			xit 'returns false'
		end

		context 'offered is empty' do
			xit 'returns false'
		end

		context 'a wanted good belongs to logged user' do
			xit 'returns false'
		end

		context 'an offered good does not belong to logged user' do
			xit 'returns false'
		end

		context 'a wanted good does not belong to the other participant' do
			xit 'returns false'
		end

		context 'all goods in wanted and offered are correct' do
			xit 'makes a new proposal'
			xit 'returns true'
		end
	end

	describe '#logged_user' do
		it 'returns nil if no user logged' do
			expect(document.logged_user).to eq nil
		end

		it 'returns logged user id if user logged' do
			proposal_container.log_in(user)
			expect(document.logged_user).to eq user.id
		end
	end

	describe '#log_in(user)' do
		context 'user present' do
			it 'sets user as the default performer for methods' do
				expect(document.log_in(user)).to eq true
			end
		end

		context 'user not present' do
			it 'returns false' do
				expect(document.log_in(user)).to eq false
			end
		end
	end
end