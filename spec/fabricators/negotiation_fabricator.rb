Fabricator(:negotiation) do
  proposals(count:1) { Fabricate.build(:negotiation_proposal) }
  messages(count:1)  { Fabricate.build(:negotiation_message) }

  after_build do |negotiation|

    #Añadir mas cosas aleatoriamente

    image_path='/images/rails.png'

    negotiation.proposals.each do |proposal|
      proposal.composer.image=image_path
      proposal.composer.products.each do |product|
        product.main_image=image_path
        product.secondary_images.each do |secondary_image|
          secondary_image.file=image_path
        end
      end
      proposal.receiver.image=image_path
      proposal.receiver.products.each do |product|
        product.main_image=image_path
        product.secondary_images.each do |secondary_image|
          secondary_image.file=image_path
        end
      end
    end

    negotiation.messages.each do |message|
      message.image=image_path
    end

  end
end
