require 'spec_helper'

describe Deal::Agreement::Proposal::Receiver::Product::Image do
  let(:image) do
    Fabricate.build(:deal_agreement_proposal_receiver_product_image, product:Fabricate.build(:deal_agreement_proposal_receiver_product, receiver:Fabricate.build(:deal_agreement_proposal_receiver, proposal:Fabricate.build(:deal_agreement_proposal, agreement:Fabricate.build(:deal_agreement, deal:Fabricate.build(:deal))))))
  end

  describe 'Relations' do
    it { should be_embedded_in(:product).of_type(Deal::Agreement::Proposal::Receiver::Product) }
  end

  describe 'Attributes' do
    # TODO: ¿Validar campo 'file' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :product }
    it { should validate_presence_of :file }
  end

  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
  end
end
