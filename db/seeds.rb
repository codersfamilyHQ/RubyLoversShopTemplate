user = User.where(email: "user@example.com").first_or_create! do |u|
  u.password = 'password'
end

admin = User.where(email: "admin@example.com").first_or_create! do |u|
  u.password = 'password'
end
