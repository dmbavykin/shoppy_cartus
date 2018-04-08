FactoryBot.define do
  factory :user, class: ShoppyCartus.user_class do
    email { FFaker::Internet.email }
  end
end
