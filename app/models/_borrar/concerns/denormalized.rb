module Denormalized
  extend ActiveSupport::Concern

  included do
    cattr_accessor :denormalized_definitions
    before_validation :load_denormalized, :if => :new_record?
  end

  module ClassMethods
    # Specify which fields to denormalize. Specify the associated object using the :from option.
    #
    # denormalize :field_one,:field_two, from:'relation'

    def denormalize(*fields)
      options = fields.pop
      (self.denormalized_definitions ||= []) << { :fields => fields, :options => options }
    end
  end

  def refresh
    reload
    load_denormalized
  end

  def refresh_denormalized
    load_denormalized
  end

  def refresh!
    refresh
    save
  end

  def refresh_denormalized!
    refresh_denormalized
    save
  end

  private
    def load_denormalized
      self.denormalized_definitions.each do |definition|

        relation = definition[:options][:from]

        associated = self.instance_eval(relation)

        definition[:fields].each do |field|
          self.send("#{field}=", associated.try(field))
        end
      end
    end
end
