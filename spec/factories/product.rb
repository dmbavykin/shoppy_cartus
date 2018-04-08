FactoryBot.define do
  factory :product, class: ShoppyCartus.product_class do
    title { FFaker::Book.title }
    price { rand(1.1...99.9).truncate(2) }
    quantity { rand(1..100) }
    publication_year { Time.now.year }
  end
end
