module DelayedUpdate
  extend ActiveSupport::Concern

  included do
    cattr_accessor :delayed_update_definition
    after_find :auto_update, if: :outdated?
    field :outdated,type:Boolean,default:false
  end

  module ClassMethods
    # Specify which fields to update. Specify the associated object using the :from option.
    #
    # denormalize :field_one,:field_two, from:'relation'

    def update_on_find(*fields)
      options = fields.pop
      self.delayed_update_definition = { :fields => fields, :options => options }
    end
  end

  private
    def auto_update

      cosa=delayed_update_definition[:options][:from]
      puts cosa

      upd_source=self.send(cosa)

      delayed_update_definition[:fields].each do |field|
        images=upd_source.send(:images)
        self.send("images=", images)
      end

    end
end