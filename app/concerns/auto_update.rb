module AutoUpdate
  extend ActiveSupport::Concern

  included do
    cattr_accessor :auto_update_definitions
    after_find :auto_update, if: :outdated?
    field :outdated, type:Boolean, default:false
  end

  module ClassMethods
    # Specify which fields to update. Specify the associated object using the :using option.
    # auto_update :field_one, :field_two, using:'relation'

    def auto_update(*fields)
      options = fields.pop
      self.auto_update_definitions = { :fields => fields, :options => options }
    end
  end

  def auto_update
    return true unless outdated?
    relation = send(auto_update_definitions[:options][:using])

    updated_values = {}

    auto_update_definitions[:fields].each do |field|
      updated_values[field] = relation.send(field)
    end

    updated_values[:outdated] = false
    assign_attributes(updated_values)
  end

  def outdate
    assign_attributes(outdated:true)
    true
  end
end
