FactoryBot.define do
  factory :user do
    name { 'username' }
    email { 'user@blog.com' }
    password { 'password' }
    confirmed_at { Time.now }
  end
end
