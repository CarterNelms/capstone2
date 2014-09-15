Fabricator(:book) do
  name { sequence(:name) { |i| "book#{i}" } }
end