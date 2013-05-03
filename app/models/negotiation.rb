class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :negotiators, class_name: 'User', inverse_of: :negotiations

  embeds_one  :conversation, class_name: 'Negotiation::Conversation', cascade_callbacks: true
  embeds_many :proposals,    class_name: 'Negotiation::Proposal', cascade_callbacks: true

  accepts_nested_attributes_for :conversation, :proposals

  validates :conversation,
    :proposals,
    presence: true

  def seal
    deal_params = {
      signers: self.negotiators,
      conversation_attributes: {
        messages_attributes: [ { user_id: negotiators.first.id, text: 'Deal signed correctly' } ]
      },
      agreement_attributes:{
        conversation_attributes: {
          messages_attributes: Array.new
        },
        proposals_attributes: Array.new
      }
    }

    self.conversation.messages.each do |message|
      deal_params[:agreement_attributes][:conversation_attributes][:messages_attributes] << {
        user_id: message.user_id,
        nick: message.nick,
        text: message.text,
        image_url: message.image_url
      }
    end

    self.proposals.each do |proposal|
      proposal_hash = {
        user_composer_id: proposal.user_composer_id,
        user_receiver_id: proposal.user_receiver_id
      }

      proposal_hash[:composer_attributes] = {
        nick: proposal.composer.nick,
        image_url: proposal.composer.image_url,
        products_attributes: Array.new
      }

      proposal.composer.products.each do |product|
        proposal_hash[:composer_attributes][:products_attributes] << {
          thing_id: product.thing_id,
          name: product.name,
          description: product.description,
          quantity: product.quantity,
          image_url: product.image_url
        }
      end

      proposal_hash[:receiver_attributes] = {
        nick: proposal.receiver.nick,
        image_url: proposal.receiver.image_url,
        products_attributes: Array.new
      }

      proposal.receiver.products.each do |product|
        proposal_hash[:receiver_attributes][:products_attributes] << {
          thing_id: product.thing_id,
          name: product.name,
          description: product.description,
          quantity: product.quantity,
          image_url: product.image_url
        }
      end

      proposal_hash[:money_attributes] = {
        user_id: proposal.money.user_id,
        quantity: proposal.money.quantity
      }

      deal_params[:agreement_attributes][:proposals_attributes] << proposal_hash
    end

    deal = Deal.new(deal_params)
    deal.save
    deal
  end
end
