Fabricator(:user) do
  nick     { Faker::Internet.user_name.slice(0,20) }
  profile  { Fabricate.build(:profile) }
end

Fabricator(:user_with_items, from: :user) do
  after_build do |user|
    user.items = 7.times.map { Fabricate(:item, user:user) }
  end
end
