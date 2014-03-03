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
    if object.class == Offer
      products(proposal(object), composer(object))
    else
      products(object, composer(object))
    end
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
    first_name(object) + " " + last_name(object)
  end

  def gender(object)
    object.profile.gender
  end

  def id(object)
    object._id
  end

  def image_service_tag(object)
    cl_image_tag(object._id + ".jpg")
  end

  def image_service_path(object)
    cl_image_path(object._id + ".jpg")
  end

  def images(object)
    user_sheet(object).images
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

  def main_image(object)
    user_sheet(object).main_image
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
    object.products(user._id)
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
    if object.class == Offer
      products(proposal(object), receiver(object))
    else
      products(object, receiver(object))
    end
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
    else
      object
    end
  end

  # Static images
  def user_header_image
    cl_image_tag(".jpg", :width => 240, :height => 160, :crop => :fill)
  end

  def no_requests_image
    cl_image_tag(".jpg", :width => 218, :height => 200, :crop => :fill)
  end

  def no_offers_image
    cl_image_tag(".jpg", :width => 269, :height => 358, :crop => :fill)
  end

  def add_item_image
    cl_image_tag(".jpg", :width => 152, :height => 152, :crop => :fill)
  end

  def star_icon_image
    cl_image_tag(".jpg", :width => 25, :height => 23, :crop => :fill)
  end

  def friends_icon_image
    cl_image_tag(".jpg", :width => 34, :height => 20, :crop => :fill)
  end

  def sound_icon_image
    cl_image_tag(".jpg", :width => 11, :height => 14, :crop => :fill)
  end

  def video_icon_image
    cl_image_tag(".jpg", :width => 20, :height => 10, :crop => :fill)
  end

  def friends_menu_icon_image
    cl_image_tag(".jpg", :width => 26, :height => 26, :crop => :fill)
  end

  def products_menu_icon_image
    cl_image_tag(".jpg", :width => 26, :height => 26, :crop => :fill)
  end

  def negotiations_menu_icon_image
    cl_image_tag(".jpg", :width => 26, :height => 26, :crop => :fill)
  end

  def deals_menu_icon_image
    cl_image_tag(".jpg", :width => 26, :height => 26, :crop => :fill)
  end

  def logout_menu_icon_image
    cl_image_tag(".jpg", :width => 19, :height => 21, :crop => :fill)
  end

  #Dynamic images
  def header_user_face_image(object)
    cl_image_tag(object._id + ".jpg", :width => 68, :height => 68, :crop => :fill, :radius => :max)
  end

  def user_logged_face_image(object)
    cl_image_tag(object._id + ".jpg", :width => 30, :height => 30, :crop => :fill, :radius => :max)
  end

  def profile_user_face_image(object)
    cl_image_tag(object._id + ".jpg", :width => 122, :height => 122, :crop => :fill)
  end

  def message_user_face_image(object)
    cl_image_tag(object._id + ".jpg", :width => 30, :height => 30, :crop => :fill)
  end

  def request_user_face_image(object)
    cl_image_tag(object._id + ".jpg", :width => 39, :height => 39, :crop => :fill)
  end

  def offer_user_face_image(object)
    cl_image_tag(object._id + ".jpg", :width => 48, :height => 48, :crop => :fill, :radius => :max)
  end

  def negotiation_user_face_image(object)
    cl_image_tag(object._id + ".jpg", :width => 64, :height => 64, :crop => :fill, :radius => :max)
  end

  def item_image_big(object)
    cl_image_tag(object._id + ".jpg", :width => 152, :height => 152, :crop => :fill)
  end

  def item_image_small(object)
    cl_image_tag(object._id + ".jpg", :width => 60, :height => 60, :crop => :fill)
  end

  #---- otros
  def cu_image_service_path(object)
    cl_image_path(object._id + ".jpg", :width => 60, :height => 60, :crop => :fill)
  end
end
