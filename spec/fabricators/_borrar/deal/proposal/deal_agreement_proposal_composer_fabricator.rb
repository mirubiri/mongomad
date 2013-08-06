Fabricator(:deal_agreement_proposal_composer, class_name: 'Deal::Agreement::Proposal::Composer') do
  transient         :composer
  proposal          nil
  products  do |attrs|
    products = []
    attrs[:composer].products.each do |product|
      products << Fabricate.build(:deal_agreement_proposal_composer_product, product:product)
    end
    products
  end
  name              { |attrs| attrs[:composer].name }
  image_fingerprint { |attrs| attrs[:composer].image_fingerprint }
end
