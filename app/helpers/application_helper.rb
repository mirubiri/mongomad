 module ApplicationHelper

  # USER HELPERS -----------------------------------------
  def user_id(user)
    user.id
  end
  def user_nick(user)
    user.nick
  end
  def user_email(user)
    user.email
  end
  def user_first_name(user)
    user.profile.first_name
  end
  def user_last_name(user)
    user.profile.last_name
  end
  def user_fullname(user)
    user.profile.first_name + " " + user.profile.last_name
  end
  def user_gender(user)
    user.profile.gender
  end
  def user_country(user)   #Does not exist in the model at the moment!!!
    'apatrida'
  end
  def user_language(user)
    user.profile.language
  end
  def user_bithdate(user)
    user.profile.bith_date
  end
  def user_image(user) # FIX helper!!!!!
    image_tag('/assets/images/sergio.jpg')
  end
  def user_items(user)
    user.items
  end
  def user_requests(user)
    user.requests
  end
  def user_sent_offers(user)
    user.sent_offers
  end
  def user_received_offers(user)
    user.received_offers
  end
  def user_negotiations(user)
    user.negotiations
  end
  def user_deals(user)
    user.deals
  end

  # ITEM HELPERS -----------------------------------------
  def item_id(item)
    item.id
  end
  def item_name(item)
    item.name
  end
  def item_description(item)
    item.description
  end
  def item_stock(item)
    item.stock
  end
  def item_image(item)
    image_tag('/assets/images/sergio.jpg')
  end

  # REQUEST HELPERS -----------------------------------------
  def request_id(request)
    request.id
  end
  def request_text(request)
    request.text
  end
  def request_image(request)
    image_tag('/assets/images/sergio.jpg')
  end

  # OFFER HELPERS -----------------------------------------
  def offer_id(offer)
    offer.id
  end
  def offer_message(offer)
    offer.message
  end
  def offer_datetime(offer)
    offer.created_at
  end

  # PRODUCT HELPERS -----------------------------------------
  def product_id(product)
    product.id
  end
  def product_name(product)
    product.name
  end
#   def product_description(product)
#     product.description
#   end
  def product_quantity(product)
    product.quantity
  end
  def product_image(product) # FIX helper!!!!!
    image_tag('/assets/images/sergio.jpg')
  end

  # NEGOTIATION HELPERS -----------------------------------------
  def negotiation_id(negotiation)
    negotiation.id
  end
  def negotiation_messages(negotiation)
    negotiation.messages
  end
  def negotiation_last_proposal(negotiation)
    negotiation.proposals.last
  end

  # PROPOSAL HELPERS -----------------------------------------
  def proposal_composer_id(proposal)
    proposal.composer_id
  end
  def proposal_composer_name(proposal) # FIX helper!!!!!
    'sergioelwapo'
  end
  def proposal_composer_fullname(proposal) # FIX helper!!!!!
    'sergio de torre'
  end
  def proposal_composer_image(proposal) # FIX helper!!!!!
    image_tag('/assets/images/sergio.jpg')
  end
  def proposal_composer_products(proposal) # FIX helper!!!!!
    proposal.left(proposal.composer_id)
  end
  def proposal_receiver_id(proposal)
    proposal.receiver_id
  end
  def proposal_receiver_name(proposal) # FIX helper!!!!!
    proposal.receiver.name
  end
  def proposal_receiver_image(proposal) # FIX helper!!!!!
    image_tag('/assets/images/sergio.jpg')
  end
  def proposal_receiver_products(proposal) # FIX helper!!!!!
    proposal.right(proposal.receiver_id)
  end
  def proposal_can_sign?(proposal, user) # FIX helper!!!!!
    #proposal.can_sign?(user)
    true
  end
  def proposal_can_confirm?(proposal, user) # FIX helper!!!!!
    #proposal.can_confirm?(user)
    true
  end
  def proposal_can_cancel?(proposal, user) # FIX helper!!!!!
    #proposal.can_cancel?(user)
    true
  end

  # MESSAGE HELPERS -----------------------------------------
  def message_text(message)
    message.text
  end
  def message_image(message) # FIX helper!!!!!
    image_tag('/assets/images/sergio.jpg')
  end
  def message_datetime(message)
    message.created_at
  end

  # DEAL HELPERS -----------------------------------------
#   def deal_id(deal)
#     deal.id
#   end
 end
