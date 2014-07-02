class Alert
  include Mongoid::Document
  include Mongoid::Timestamps
  include Ownership

  ownership :single

  field :text
  field :location, type: Array
end
