User.create!(
  first_name: 'Kyle',
  last_name: 'Tress',
  email: 'kyle@kyletress.com',
  password_digest: User.digest('password'),
  admin: true
)