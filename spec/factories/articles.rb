FactoryBot.define do
  factory :article do
    title { "MyString" }
    content { "MyText" }
    user
  end
end
