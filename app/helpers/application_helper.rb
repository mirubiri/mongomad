 module ApplicationHelper

  # COMMON HELPERS
  def id(object)
    object.id
  end
  def name(object)
    object.name
  end
  def description(object)
    object.description
  end
  def text(object)
    object.text
  end
  def image(object)
    cl_image_tag(object.images.where(main:true).first.id+".jpg")
  end

  # def image(object,width,height)
  #   cl_image_tag(object.images.where(main:true).first.id,width:width,height:height)
  # end
  def messages(object)
    object.messages
  end
  def date_time(object)
    object.created_at
  end

  # USER HELPERS
  def nick(user)
    user.nick
  end
  def email(user)
    user.email
  end
  def first_name(user)
    user.profile.first_name
  end
  def last_name(user)
    user.profile.last_name
  end
  def full_name(user)
    user.profile.first_name + " " + user.profile.last_name
  end
  # def gender(user) #FIX: Not used
  #   user.profile.gender
  # end
  # def language(user) #FIX: Not used
  #   user.profile.language
  # end
  def birth_date(user)
    user.profile.birth_date
  end
  # def country(user) #FIX: Does not exist in the model (at the moment)!!!
  #   'apatrida'
  # end
  def items(user)
    user.items
  end
  def requests(user)
    user.requests
  end
  # def sent_offers(user) #FIX: Not used
  #   user.sent_offers
  # end
  def received_offers(user)
    user.received_offers
  end
  def negotiations(user)
    user.negotiations
  end
  def deals(user)
    user.deals
  end
  def deal_image(deal) #FIX helper!!!!!
    #image_tag(object.image)
    image_tag('/assets/images/productos2.png')
  end

  # ALERT HELPERS
  def alerts(user)
    4
  end

  # ITEM HELPERS
  def stock(item)
    item.stock
  end

  # OFFER HELPERS
  def message(offer)
    offer.message
  end

  # PRODUCT HELPERS
  def quantity(product)
    product.quantity
  end

  # NEGOTIATION HELPERS
  def last_proposal(negotiation)
    negotiation.proposals.last
  end

  # PROPOSAL HELPERS
  def composer_id(proposal)
    proposal.composer_id
  end
  def composer_first_name(proposal)
    proposal.user_sheets.where(id:proposal.composer_id).last.first_name
  end
  def composer_full_name(proposal)
    sheet = proposal.user_sheets.where(id:proposal.composer_id).last
    sheet.first_name + " " + sheet.last_name
  end
  def composer_image(proposal)
    #proposal.proposal_container.user_sheets.where(id:proposal.receiver_id).last.image
    image_tag('/assets/images/medico.jpg')
  end
  def composer_products(proposal) # FIX helper!!!!!
    proposal.products(proposal.composer_id)
  end
  def receiver_id(proposal)
    proposal.receiver_id
  end
  def receiver_first_name(proposal) #FIX: Not used
    'Sergio' #proposal.proposal_container.user_sheets.where(id:proposal.receiver_id).last.first_name
  end
  def receiver_full_name(proposal)
    #sheet = proposal.proposal_container.user_sheets.where(id:proposal.receiver_id).last
    #sheet.first_name + " " + sheet.last_name
    'Sergio de Torre'
  end
  def receiver_image(proposal)
    #proposal.proposal_container.user_sheets.where(id:proposal.receiver_id).last.image
    image_tag('/assets/images/sergio.jpg')
  end
  def receiver_products(proposal) # FIX helper!!!!!
    proposal.products(proposal.receiver_id)
  end
  def can_sign?(proposal, user) # FIX helper!!!!!
    #proposal.can_sign?(user)
    true
  end
  def can_confirm?(proposal, user) # FIX helper!!!!!
    #proposal.can_confirm?(user)
    false
  end
  def can_cancel?(proposal, user) # FIX helper!!!!!
    #proposal.can_cancel?(user)
    true
  end


 end
