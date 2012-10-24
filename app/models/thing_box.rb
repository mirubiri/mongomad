class ThingBox
  include Mongoid::Document
  embedded_in :user
  embeds_many :things
end
