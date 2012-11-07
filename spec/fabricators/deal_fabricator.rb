Fabricator(:deal) do
  messages { [Fabricate.build(:message)] }

  after_build do |deal|
    deal.agreement = Fabricate.build(:agreement,deal:deal)
  end
end