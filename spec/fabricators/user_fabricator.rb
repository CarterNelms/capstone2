Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password { "password1" }
  # library_id { Fabricate(:library).id }
  wanted_list_id { Fabricate(:wanted_list).id }
  confirmed_at { DateTime.now }
end