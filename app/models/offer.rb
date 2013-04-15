class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user_composer, class_name: "User", inverse_of: :sent_offers
  belongs_to :user_receiver, class_name: "User", inverse_of: :received_offers

  embeds_one :composer, class_name: "Offer::Composer", cascade_callbacks: true
  embeds_one :receiver, class_name: "Offer::Receiver", cascade_callbacks: true
  embeds_one :money,    class_name: "Offer::Money", cascade_callbacks: true

  field :initial_message, type: String

  accepts_nested_attributes_for :composer, :receiver, :money

  validates :user_composer,
    :user_receiver,
    :composer,
    :receiver,
    :money,
    :initial_message,
    presence: true

  validates :initial_message,
    length: { minimum: 1, maximum: 160 }

  def start_negotiation
    negotiation_params = {
      #negotiators: [ self.user_composer, self.user_receiver ],
      conversation_attributes: {
        messages_attributes: [
          { user_id:self.user_composer_id, text:self.initial_message }
        ]
      },
      proposals_attributes:Array.new
    }
#     puts negotiation_params
# negotiation = Negotiation.new(negotiation_params)
# ap negotiation
puts '111111111111111111111111111111111111111111111111111111111111111111'
    proposal_hash = Hash.new
    proposal_hash[:user_composer_id] = self.user_composer_id
    proposal_hash[:user_receiver_id] = self.user_receiver_id

    proposal_hash[:composer_attributes] = { products_attributes:Array.new }
    self.composer.products.each_with_index do |product, index|
      proposal_hash[:composer_attributes][:products_attributes][index]= { thing_id:product.thing_id, quantity:product.quantity }
    end

    proposal_hash[:receiver_attributes] = { products_attributes:Array.new }
    self.receiver.products.each_with_index do |product, index|
      proposal_hash[:receiver_attributes][:products_attributes][index]= { thing_id:product.thing_id, quantity:product.quantity }
    end

    proposal_hash[:money_attributes] = { user_id:self.money.user_id, quantity:self.money.quantity }

    negotiation_params[:proposals_attributes][0] = proposal_hash

puts proposal_hash
puts negotiation_params




puts '333333333333333333333333333333333333333333333333333333'
    negotiation = Negotiation.new(negotiation_params)
puts negotiation._id
negotiation.negotiators = [ user_composer, user_receiver ]
#puts negotiation.negotiators
#puts 'aaaaaaaaaaaa'
    negotiation.save

    user_composer.negotiations << negotiation
    user_composer.save
   user_receiver.negotiations << negotiation
       user_receiver.save
#puts = self.user_composer
#puts = self.user_receiver

     #puts negotiation_params
    #negotiation.save
    negotiation
  end
end
