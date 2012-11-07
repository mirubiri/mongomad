Fabricator(:user) do
    user.profile { Fabricate.build(:profile) }
    user.things { Fabricate.build(:thing) }
    user.requests { [Fabricate.build(:request) ] }
  end
end