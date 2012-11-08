Fabricator(:composer) do

  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
  full_name 'full name'

  after_build do |composer|
    composer.products << Fabricate.build(:product,offer:offer)
  end
end