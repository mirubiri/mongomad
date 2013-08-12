class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :sender,   class_name: 'User', inverse_of: :sent_offers
  belongs_to :receiver, class_name: 'User', inverse_of: :received_offers

  embeds_one :proposal, as: :polymorphic_proposal
  embeds_one :sender_sheet,   class_name:'UserSheet', as: :user_sheet_container
  embeds_one :receiver_sheet, class_name:'UserSheet', as: :user_sheet_container

  field :message

  validates_presence_of :sender, :receiver, :proposal, :sender_sheet, :receiver_sheet, :message

  validates :message, length: { minimum: 1, maximum: 160 }

#   def start_negotiation
#     negotiation = nil

#     if self.persisted?
#       negotiation_params = {
#         negotiators: [ user_composer, user_receiver ],
#         conversation_attributes: {
#           messages_attributes: [ {
#             user_id: user_composer_id,
#             text: initial_message
#           } ]
#         },
#         proposals_attributes: Array.new
#       }

#       negotiation_params[:proposals_attributes] << fill_proposal_hash

#       negotiation = Negotiation.new(negotiation_params)
#       negotiation.save
#     end

#     negotiation
#   end

#   private
#   def fill_proposal_hash
#     proposal_hash = {
#       user_composer_id: self.user_composer_id,
#       user_receiver_id: self.user_receiver_id,
#       composer_attributes: {
#         products_attributes: Array.new
#       },
#       receiver_attributes: {
#         products_attributes: Array.new
#       },
#       money_attributes: {
#         user_id: self.money.user_id,
#         quantity: self.money.quantity
#       }
#     }

#     #TODO: Unir ambas inicializaciones composer/receiver
#     self.composer.products.each do |product|
#       proposal_hash[:composer_attributes][:products_attributes] << {
#         thing_id: product.thing_id,
#         quantity: product.quantity
#       }
#     end

#     self.receiver.products.each do |product|
#       proposal_hash[:receiver_attributes][:products_attributes] << {
#         thing_id: product.thing_id,
#         quantity: product.quantity
#       }
#     end

#     proposal_hash
#   end
end
