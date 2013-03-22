shared_examples_for Mongoid::Denormalize do
  definitions={ self.denormalize_definitions }

  definitions.each do |definition|
  	definition[:fields].each do |field|
  		specify { self.send(field).should eq definition[:from].field }
  	end
  end
end