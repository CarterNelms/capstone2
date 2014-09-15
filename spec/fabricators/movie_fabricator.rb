Fabricator(:movie) do
  name { sequence(:name) { |i| "movie#{i}" } }
end