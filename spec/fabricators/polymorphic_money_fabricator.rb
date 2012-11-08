Fabricator(:polymorphic_money) do
  #Relations
  offer
 # after_build do |polymorphic_money|
 #   polymorphic_money.money = Fabricate.build(:money,polymorphic_money:polymorphic_money)
 # end
end