Fabricator(:user) do
  nick     { Faker::Internet.user_name }
  profile  { Fabricate.build(:profile) }
end

Fabricator(:user_with_items, from: :user) do
  after_build do |user|
    user.items = 3.times.map { Fabricate(:item, user:user) }
  end
end
