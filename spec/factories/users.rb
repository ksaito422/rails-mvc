FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "test@test.com" }
    password { "test1234" }
    password_confirmation { "test1234" }
  end
end
