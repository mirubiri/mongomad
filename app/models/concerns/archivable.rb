module Archivable
	extend ActiveSupport::Concern

  included do
    field :_archived, type:Boolean, default:false
  	default_scope where(_archived:false)
  end

  def archive
  	archived? || persisted? && update_attributes(_archived:true)
  end

  def archived?
  	_archived
  end
end