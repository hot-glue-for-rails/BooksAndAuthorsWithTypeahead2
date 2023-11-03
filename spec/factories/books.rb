FactoryBot.define do
  factory :book do
    author { build(:author) }
    title { FFaker::Book.title }
  end
end
