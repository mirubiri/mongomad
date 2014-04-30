RSpec::Matchers.define :only_set_once do |getter|
  match do |klass|
  	klass.send(@setter,double().as_null_object) if klass.send(getter).nil?
  	current=klass.send(getter)

  	klass.send(@setter,double().as_null_object)
  	klass.send(getter) == current
  end

  chain :with do |setter|
    @setter = setter
  end
end