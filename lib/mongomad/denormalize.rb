module Mongomad::Denormalize
  extend ActiveSupport::Concern

  included do
    cattr_accessor :denormalized_definitions
    before_validation :denormalize_from, :if => :new_record?
  end

  module ClassMethods
    # Specify which fields to denormalize. Specify the associated object using the :from option.
    #
    # denormalize :field_one,:field_two, from:'relation'

    def denormalize(*fields)
      options = fields.pop
      (self.denormalized_definitions ||= []) << { :fields => fields, :options => options }
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
        self.denormalized_definitions.each do |definition|
          definition[:fields].each do |field|
            relation = definition[:options][:from]

            # force reload of association specified by :from
            associated = self.instance_eval(relation).reload

            self.send("#{field}=", associated.try(field))
          end
        end
    end
end
