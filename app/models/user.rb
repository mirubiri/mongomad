class User
  include Mongoid::Document
  include Mongoid::Timestamps

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
    self.disabled = false
  end

  def disable
    self.disabled = true
  end
end
