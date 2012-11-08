Fabricator(:deal) do
  after_build do |deal|
    deal.agreement = Fabricate.build(:agreement,deal:deal)
  end
end