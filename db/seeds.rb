user = User.where(email: "user@example.com").first_or_create! do |u|
  u.password = 'password'
end
