Fabricator(:user_sheet) do
  id          { Faker::Code.isbn }
  nick        { Faker::Internet.user_name }
  full_name   { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  images      {[ Fabricate.build(:image, main:true) ]}
  location    { [Faker::Address.longitude,Faker::Address.latitude]}
end