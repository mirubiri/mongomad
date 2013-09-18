 module ApplicationHelper

#   # USER (USER_LOGGED) HELPERS -----------------------------------------
  def user_logged_id(user = user_logged)
    current_user.id
  end
  def user_logged_name(user = user_logged)
    user.profile.first_name
  end
  def user_logged_surname(user = user_logged)
    user.profile.last_name
  end
#   def user_logged_name(user = user_logged)
#     user.nick
#   end
#   def user_logged_sex(user = user_logged)
#     user.profile.gender
#   end
#   def user_logged_country(user = user_logged)
#     'spain'
#   end
#   def user_logged_delivery_adress(user = user_logged)
#     user.profile.delivery_adress
#   end
#   def user_logged_phone_number(user = user_logged)
#     user.profile.phone_number
#   end
#   def user_logged_website(user = user_logged)
#     user.profile.website
#   end
#   def user_logged_bithdate(user = user_logged)
#     user.profile.bithdate
#   end
  def user_logged_image(user = user_logged)
    image_tag('/assets/images/sergio.jpg')
  end
#   def user_logged_datetime(user = user_logged)
#     user.profile.created_at
#   end
#   def user_logged_updatetime(user = user_logged)
#     user.profile.updated_at
#   end
#   def user_logged_things(user = user_logged)
#     user.things
#   end
#   def user_logged_requests(user = user_logged)
#     user.requests
#   end
#   def user_logged_sent_offers(user = user_logged)
#     user.sent_offers
#   end
#   #TODO: Cambiar nombre a 'user_logged_received_offers'
#   #def user_logged_received_offers(user = user_logged)
#   def user_logged_offers(user = user_logged)
#     user.received_offers
#   end
  def user_logged_negotiations(user = user_logged)
    user.negotiations
  end
#   def user_logged_deals(user = user_logged)
#     user.deals
#   end

#   # USER (USER_VISITED) HELPERS -----------------------------------------
  def user_visited_id
    @user.id
  end
  def user_visited_fullname
    @user.nick + " " + @user.profile.last_name
  end
#   def user_visited_surname
#     @user.profile.last_name
#   end
#   def user_visited_name
#     @user.nick
#   end
#   def user_visited_sex
#     @user.profile.gender
#   end
  def user_visited_country
    'spain'
  end
#   def user_visited_delivery_adress
#     @user.profile.delivery_adress
#   endf
#   def user_visited_phone_number
#     @user.profile.phone_number
#   end
#   def user_visited_website
#     @user.profile.website
#   end
  def user_visited_email
    @user.email
  end
  def user_visited_birthdate
    @user.profile.birth_date
  end
  def user_visited_image
    image_tag('/assets/images/medico.jpg')
  end
#   def user_visited_datetime
#     @user.profile.created_at
#   end
#   def user_visited_updatetime
#     @user.profile.updated_at
#   end
  def user_visited_items
    @user.items
  end
  def user_visited_requests
    @user.requests
  end
#   def user_visited_sent_offers
#     @user.sent_offers
#   end
#   #TODO: Cambiar nombre a 'user_visited_received_offers'
#   #def user_visited_received_offers
   def user_visited_offers
     @user.received_offers
   end
#   def user_visited_negotiations
#     @user.negotiations
#   end
#   def user_visited_deals
#     @user.deals
#   end
#   def user_requests
#     @user.requests
#   end

#   # ITEM HELPERS -----------------------------------------
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
    image_tag('/assets/images/medico.jpg')
  end

#   # REQUEST HELPERS -----------------------------------------
  def request_id(request)
    request.id
  end
#   # def request_user_id(request)
#   #   request.user.id
#   # end
#   # def request_user_name(request)
#   #   request.name
#   # end
  def request_text(request)
    request.text
  end
  def request_image(request)
    image_tag('/uploads/sergio.jpg')
  end
#   # def request_datetime(request)
#   #   request.created_at
#   # end
#   # def request_updatetime(request)
#   #   request.updated_at
#   # end

#   # OFFER HELPERS -----------------------------------------
  def offer_id(offer)
    offer.id
  end
#   def offer_composer_id(offer)
#     offer.user_composer_id
#   end
  # def offer_composer_name(offer)
  #   offer.composer.name
  # end
#   def offer_composer_name(offer)
#     offer.user_composer.name + " " + offer.user_composer.profile.surname
#   end
#   def offer_composer_products(offer)
#     offer.composer.products
#   end
#   def offer_composer_things(offer)
#     offer.user_composer.things
#   end
#   def offer_receiver_id(offer)
#     offer.user_receiver_id
#   end
#   def offer_receiver_name(offer)
#     offer.receiver.name
#   end
#   def offer_receiver_products(offer)
#     offer.receiver.products
#   end
#   def offer_receiver_things(offer)
#     offer.user_receiver.things
#   end
#   def offer_money_owner_id(offer)
#     offer.money.user_id
#   end
#   def offer_money_quantity(offer)
#     offer.money.quantity
#   end
  def offer_message(offer)
    offer.message
  end
  def offer_datetime(offer)
    offer.created_at
  end
#   def offer_updatetime(offer)
#     offer.updated_at
#   end

#   # PRODUCT HELPERS -----------------------------------------
  def product_id(product)
    product.id
  end
#   def product_item_id(product)
#     product.item_id
#   end
  def product_name(product)
    product.name
  end
#   def product_description(product)
#     product.description
#   end
  def product_quantity(product)
    product.quantity
  end
  def product_image(product)
    image_tag('/uploads/coche.jpg')
  end

#   # NEGOTIATION HELPERS -----------------------------------------
  def negotiation_id(negotiation)
    negotiation.id
  end
#   def negotiation_negotiators(negotiation)
#     negotiation.negotiators
#   end
#   def negotiation_proposals(negotiation)
#     negotiation.proposals
#   end
#   def negotiation_conversation(negotiation)
#     negotiation.conversation
#   end
  def negotiation_messages(negotiation)
    negotiation.messages
  end
  def negotiation_last_proposal(negotiation)
    negotiation.proposals.last
  end

#   # PROPOSAL HELPERS -----------------------------------------
#   def proposal_id(proposal)
#     proposal.id
#   end
#   def proposal_composer(proposal)
#     proposal.user_composer
#   end
  def proposal_composer_id(proposal)
    proposal.composer_id
  end
  def proposal_composer_name(proposal)
    'sergioelwapo'
  end
  def proposal_composer_fullname(proposal)
    'sergio de torre'
  end
  def proposal_composer_image(proposal)
    image_tag('/uploads/sergio.jpg')
  end
  def proposal_composer_products(proposal)
    proposal.left(proposal.composer_id)
  end
#   def proposal_composer_things(proposal)
#     proposal.user_composer.things
#   end
#   def proposal_receiver(proposal)
#     proposal.user_receiver
#   end
  def proposal_receiver_id(proposal)
    proposal.receiver_id
  end
  def proposal_receiver_name(proposal)
    proposal.receiver.name
  end
  def proposal_receiver_image(proposal)
    image_tag('/uploads/medico.jpg')
  end
  def proposal_receiver_products(proposal)
    proposal.right(proposal.receiver_id)
  end
#   def proposal_receiver_things(proposal)
#     proposal.user_receiver.things
#   end
#   def proposal_money_owner_id(proposal)
#     proposal.money.user_id
#   end
#   def proposal_money_quantity(proposal)
#     proposal.money.quantity
#   end
#   def proposal_datetime(proposal)
#     proposal.created_at
#   end
#   def proposal_updatetime(proposal)
#     proposal.updated_at
#   end
  def proposal_can_sign?(proposal, user)
    #proposal.can_sign?(user)
    true
  end
  def proposal_can_confirm?(proposal, user)
    #proposal.can_confirm?(user)
    true
  end
  def proposal_can_cancel?(proposal, user)
    #proposal.can_cancel?(user)
    true
  end

#   # MESSAGE HELPERS -----------------------------------------
#   def message_id(message)
#     message.id
#   end
#   def message_user_id(message)
#     message.user_id
#   end
#   def message_user_name(message)
#     message.name
#   end
  def message_text(message)
    message.text
  end
  def message_image(message)
    image_tag('/uploads/sergio.jpg')
  end
  def message_datetime(message)
    message.created_at
  end
#   def message_updatetime(message)
#     message.updated_at
#   end

#   # DEAL HELPERS -----------------------------------------
#   def deal_id(deal)
#     deal.id
#   end
#   def deal_signers(deal)
#     deal.signers
#   end
#   def deal_agreement(deal)
#     deal.agreement
#   end
#   def deal_conversation(deal)
#     deal.messages
#   end
#   #Aqui falta mucha fiesta
#   def deal_datetime(deal)
#     deal.created_at
#   end
#   def deal_updatetime(deal)
#     deal.updated_at
#   end

#   # AGREEMENT HELPERS -----------------------------------------
#   def agreement_id(agreement)
#     agreement.id
#   end
#   def agreement_proposals(agreement)
#     agreement.proposals
#   end
#   def agreement_conversation(agreement)
#     agreement.conversation
#   end
#   def agreement_datetime(agreement)
#     agreement.created_at
#   end
#   def agreement_updatetime(agreement)
#     agreement.updated_at
#   end

#   # ALERTS HELPERS -----------------------------------------
#   def user_alerts
#     @user.requests
#   end
 end
