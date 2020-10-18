user = User.where(email: "user@example.com").first_or_create! do |u|
  u.password = 'password'
end

admin = AdminUser.where(email: "admin@example.com").first_or_create! do |a|
  a.password = 'password'
end
