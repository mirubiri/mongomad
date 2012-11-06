Fabricator(:composer) do
  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
  full_name 'complete name'
end