class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users, class_name: 'User', inverse_of: :negotiations

  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container

  validates_presence_of :proposals, :messages

  #accepts_nested_attributes_for :conversation, :proposals

#   def seal_deal
#     deal = nil
#     proposal = proposals.last

#     if self.persisted? && (proposal.confirm_composer || proposal.confirm_receiver)
#       deal_params = {
#         signers: self.negotiators,
#         conversation_attributes: {
#           messages_attributes: Array.new
#         },
#         agreement_attributes: fill_agreement_hash
#       }

#       deal = Deal.new(deal_params)
#       deal.save
#       self.destroy
#     end

#     deal
#   end

#   private
#   def fill_agreement_hash
#     agreement_hash = {
#       conversation_attributes: fill_conversation_hash,
#       proposals_attributes: Array.new
#     }

#     self.proposals.each do |proposal|
#       agreement_hash[:proposals_attributes] << fill_proposal_hash(proposal)
#     end

#     agreement_hash
#   end

#   def fill_conversation_hash
#     conversation_hash = {
#       messages_attributes: Array.new
#     }

#     self.conversation.messages.each do |message|
#       conversation_hash[:messages_attributes] << fill_message_hash(message)
#     end

#     conversation_hash
#   end

#   def fill_message_hash(message)
#     message_hash = {
#       user_id: message.user_id,
#       name: message.name,
#       text: message.text,
#       image_url: message.image_url,
#       image_fingerprint: message.image_fingerprint
#     }
#     message_hash
#   end

#   def fill_proposal_hash(proposal)
#     proposal_hash = {
#       user_composer_id: proposal.user_composer_id,
#       user_receiver_id: proposal.user_receiver_id,
#       composer_attributes: {
#         name: proposal.user_composer.name,
#         image_url: proposal.user_composer.profile.image_url,
#         image_fingerprint: proposal.user_composer.profile.image_fingerprint,
#         products_attributes: Array.new
#       },
#       receiver_attributes: {
#         name: proposal.user_receiver.name,
#         image_url: proposal.user_receiver.profile.image_url,
#         image_fingerprint: proposal.user_receiver.profile.image_fingerprint,
#         products_attributes: Array.new
#       },
#       money_attributes: {
#         user_id: proposal.money.user_id,
#         quantity: proposal.money.quantity
#       }
#     }

#     #TODO: Unir ambas inicializaciones composer/receiver
#     proposal.composer.products.each do |product|
#       thing = proposal.user_composer.things.find(product.thing_id)
#       proposal_hash[:composer_attributes][:products_attributes] << {
#         thing_id: product.thing_id,
#         name: thing.name,
#         description: thing.description,
#         quantity: product.quantity,
#         image_url: thing.image_url,
#         image_fingerprint: thing.image_fingerprint
#       }
#     end

#     proposal.receiver.products.each do |product|
#       thing = proposal.user_receiver.things.find(product.thing_id)
#       proposal_hash[:receiver_attributes][:products_attributes] << {
#         thing_id: product.thing_id,
#         name: thing.name,
#         description: thing.description,
#         quantity: product.quantity,
#         image_url: thing.image_url,
#         image_fingerprint: thing.image_fingerprint
#       }
#     end

#     proposal_hash
#   end
end
