Fabricator(:deal) do
  agreement         { Fabricate.build(:deal_agreement) }
  messages(count:1) { Fabricate.build(:deal_message) }

  after_build do |deal|

    #Añadir mas cosas aleatoriamente

    image_path='/images/rails.png'

    deal.agreement.proposals.each do |proposal|
      proposal.composer.products.each do |product|
        product.main_image=image_path
      end
      proposal.receiver.products.each do |product|
        product.main_image=image_path
      end
    end

  end
end
