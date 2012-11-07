Fabricator(:user) do
    profile { Fabricate.build(:profile) }
end