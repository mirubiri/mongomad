require 'spec_helper'

describe ItemUnregister do
  # Variables
  let(:item) { Fabricate.build(:item) }
  let(:item_register) { ItemRegister.new }

  # Methods
  describe '#execute' do
    # Item
    context 'when item is discarded' do
      before(:each) { item.state = 'discarded' }

      it 'does not change item state' do
        expect{ item_register.execute }.to_not change { item.state }
      end
    end

    context 'when item is not discarded' do
      before(:each) { item.state = 'available' }

      it 'changes item state to discarded' do
        expect{ item_register.execute }.to change { item.state }.from(item.state).to('discarded')
      end
    end

    context 'when item belongs to any offer' do
      let(:offer) { Fabricate.build(:offer) }
      let(:proposal) { offer.proposal }      
      let(:product) { proposal.goods.first }   
     
      # Product
      context 'when product is avaliable or unavaliable' do
        before(:each) { product.state = 'available' }

        it 'changes product state to ghosted' do
          expect{ item_register.execute }.to change { product.state }.from(product.state).to('ghosted')
        end
      end

      context 'when product is not avaliable nor unavaliable' do
        #context 'when product is ghosted or discarded' do
        before(:each) { product.state = 'discarded' }

        it 'does not change product state' do
          expect{ item_register.execute }.to_not change { product.state }
        end
      end

      # Proposal
      context 'when proposal is new, signed or broken' do
        before(:each) { proposal.state = 'new' }

        it 'changes proposal state to ghosted' do
          expect{ item_register.execute }.to change { proposal.state }.from(proposal.state).to('ghosted')
        end
      end

      context 'when proposal is not new, not signed nor broken' do
        #context when proposal is confirmed, ghosted or discarded do
        before(:each) { product.state = 'discarded' }

        it 'does not change proposal state' do
          expect{ item_register.execute }.to_not change { proposal.state }
        end
      end

      # Offer
      context 'when offer is ghosted or discarded' do
        before(:each) { offer.state = 'discarded' }

        it 'does not change offer state' do
          expect{ item_register.execute }.to_not change { offer.state }
        end
      end

      context 'when offer is not ghosted nor discarded' do
        #context 'when offer is new, negotiating or negotiated
        before(:each) { product.state = 'new' }

        it 'changes offer state to ghosted' do
          expect{ item_register.execute }.to change { offer.state }.from(offer.state).to('ghosted')
        end     
      end
    end

    context 'when item belongs to any negotiation' do
      let(:negotiation) { Fabricate.build(:negotiation) }
      let(:proposal) { negotiation.proposal }      
      let(:product) { proposal.goods.first }   

      # Product
      context 'when product is avaliable or unavaliable' do
        before(:each) { product.state = 'available' }

        it 'changes product state to ghosted' do
          expect{ item_register.execute }.to change { product.state }.from(product.state).to('ghosted')
        end
      end

      context 'when product is not avaliable nor unavaliable' do
        #context 'when product is ghosted or discarded' do
        before(:each) { product.state = 'discarded' }

        it 'does not change product state' do
          expect{ item_register.execute }.to_not change { product.state }
        end
      end

      # Proposal
      context 'when proposal is new, signed or broken' do
        before(:each) { proposal.state = 'new' }

        it 'changes proposal state to ghosted' do
          expect{ item_register.execute }.to change { proposal.state }.from(proposal.state).to('ghosted')
        end
      end

      context 'when proposal is not new, not signed nor broken' do
        #context when proposal is confirmed, ghosted or discarded do
        before(:each) { product.state = 'discarded' }

        it 'does not change proposal state' do
          expect{ item_register.execute }.to_not change { proposal.state }
        end
      end

      # Negotiation
      it 'does not change negotiation state' do
        expect{ item_register.execute }.to_not change { negotiation.state }
      end
    end
  end
end
