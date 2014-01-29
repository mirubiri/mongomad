 module ApplicationHelper
  def alerts(object)
    object.alerts
  end

  def agreement(object)
    object.agreement
  end

  def birth_date(object)
    object.profile.birth_date
  end

  def composer(object)
    object.composer
  end

  def composer_products(object)
    products(object, object.composer)
  end

  def date_time(object)
    object.created_at
  end

  def deals(object)
    object.deals
  end

  def description(object)
    object.description
  end

  def first_name(object)
    user_sheet(object).first_name
  end

  def full_name(object)
    first_name(object) + last_name(object)
  end

  def gender(object)
    object.profile.gender
  end

  def id(object)
    object._id
  end

  def images(object)
    if ['User','Request','Message'].include?(object.class)
      user_sheet(object).images
    else
      object.images
    end
  end

  def items(object)
    User.find(object._id).items
  end

  def language(object)
    object.profile.language
  end

  def last_name(object)
    user_sheet(object).last_name
  end

  def location(object)
    user_sheet(object).location
  end

  def main_image(object)
    if ['User','Request','Message'].include?(object.class)
      cl_image_tag(user_sheet(object).main_image._id + ".jpg")
    else
      cl_image_tag(object.main_image._id + ".jpg")
    end
  end

  def main_image_path(object)
    if ['User','Request','Message'].include?(object.class)
      cl_image_path(user_sheet(object).main_image._id + ".jpg")
    else
      cl_image_path(object.main_image._id + ".jpg")
    end
  end

  def message(object)
    if object.class == Offer
      object.message
    else
      messages(object).last
    end
  end

  def messages(object)
    object.messages
  end

  def name(object)
    object.name
  end

  def negotiations(object)
    object.negotiations
  end

  def nick(object)
    user_sheet(object).nick
  end

  def products(object, user)
    if object.class == Offer
      object.proposal.products(user._id)
    else
      object.products(user._id)
    end
  end

  def proposal(object)
    object.proposal
  end

  def proposals(object)
    object.proposals
  end

  def quantity(object)
    object.quantity
  end

  def received_offers(object)
    object.received_offers
  end

  def receiver(object)
    object.receiver
  end

  def receiver_products(object)
    products(object, object.receiver)
  end

  def requests(object)
    object.requests
  end

  def sent_offers(object)
    object.sent_offers
  end

  def state(object)
    object.state
  end

  def stock(object)
    object.stock
  end

  def text(object)
    object.text
  end

  def user(object)
    object.user
  end

  def user_sheet(object)
    if object.class == User
      object.sheet
    elsif object.class == Request
      object.user_sheet
    elsif object.class == Message
      object.user
    else # class == UserSheet
      object
    end
  end
end
