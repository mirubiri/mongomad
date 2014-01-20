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
  field :state, default:'active'

  validates_presence_of :profile, :nick
  validates_inclusion_of :state, in: ['active','inactive']

  def enable
    if state == 'inactive'
      self.state = 'active'
      true
    else
      false
    end
  end

  def disable
    if state == 'active'
      self.state = 'inactive'
      true
    else
      false
    end
  end

  def sheet
    UserSheet.new(nick:nick,
      first_name:profile.first_name,
      last_name:profile.last_name,
      images:profile.images,
      location:profile.location) do |sheet|
        sheet._id = id
      end
  end
end
