class Validator
  attr_accessor :model, :model_dup

  def initialize(model)
    duplicate(model)
    self.model = model
  end

  def duplicate(model)
    self.model_dup = model.dup
    self.model_dup.id = model.id if model.respond_to?(:id)
  end

  def method_missing(method, *params, &block)
    model_dup.send(method, *params, &block)
    result = model_dup.valid?
    if result
      new_validator = Validator.new model
      new_validator.model_dup = model.send(method, *params, &block)
      new_validator
    else
      duplicate(model)
      result
    end
  end
end
