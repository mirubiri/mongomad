module Archivable
	extend ActiveSupport::Concern

  included do
    field :archived, type:Mongoid::Boolean, default:false
  	default_scope ->{ where(archived:false) }
  end

  def archive
  	archived? || persisted? && update_attributes(archived:true)
  end

  def unarchive
    archived? && persisted? && update_attributes(archived:false)
  end
end
