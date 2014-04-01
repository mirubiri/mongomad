class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many                :requests
  has_many                :sent_offers,     class_name: 'Offer', inverse_of: :user_composer
  has_many                :received_offers, class_name: 'Offer', inverse_of: :user_receiver
  has_and_belongs_to_many :negotiations
  has_and_belongs_to_many :deals
  has_many                :items
  has_many                :alerts
  embeds_one              :profile

  field :nick
  field :disabled, type:Boolean, default:false

  validates_presence_of :profile, :disabled
  validates_length_of   :nick, minimum: 1, maximum: 20

  def sheet
    UserSheet.new(nick:nick, first_name:profile.first_name, last_name:profile.last_name, images:profile.images, location:profile.location) do |sheet|
      sheet.id = id
    end
  end

  def enable
    !disabled ? false : begin
      self.disabled = false
      true
    end
  end

  def disable
    disabled? ? false : self.disabled = true
  end
end
