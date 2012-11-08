Fabricator(:product) do
  polymorphic_product { Fabricate.build(:composer) }
  thing_id { Fabricate.build(:thing)._id }
  name 'name'
  description 'description'
  quantity 5
end

=begin
Fabricator(:product :receiver) do
  polymorphic_product { Fabricate.build(:receiver) }
  thing_id { Fabricate.build(:thing)._id }
  name 'name'
  description 'description'
  quantity 5
end
=end