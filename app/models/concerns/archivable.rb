module Archivable
	extend ActiveSupport::Concern

  included do
    field :archived, type:Boolean, default:true
  	default_scope where(archived:false)
  end
end