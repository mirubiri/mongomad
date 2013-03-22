module Mongomad::Denormalize
  extend ActiveSupport::Concern
  
  included do
    cattr_accessor :denormalize_definitions
    before_validation :denormalize_from
  end

  module ClassMethods
    # Set a field or a number of fields to denormalize. Specify the associated object using the :from option.
    #
    # denormalize :one_field,:two_field, from:'relation',type:String

    def denormalize(*fields)
      options = fields.pop
      (self.denormalize_definitions ||= []) << { :fields => fields, :options => options }
      #fields.each { |field_name| field "#{field_name}", :type => options[:type] || String }
    end
    
    def is_denormalized?
      true
    end
  end

  def denormalized_valid?
    denormalize_from
    !self.changed?
  end

  def self_update!
    self.save! unless denormalized_valid?
  end
  
  private
    def denormalize_from
      self.denormalize_definitions.each do |definition|
        definition[:fields].each do |field|
          relation = definition[:options][:from]
          
          # force reload of association specified by :from
          associated = self.instance_eval(relation).reload
          
          self.send("#{field}=", associated.try(field))
        end
      end
    end
end
