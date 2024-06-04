FactoryBot.define do
  factory :item do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user
    category { Category.all.sample }
    condition { Condition.all.sample }
    prefecture { Prefecture.all.sample }
    shipping_cost { ShippingCost.all.sample }
    shipping_duration { ShippingDuration.all.sample }

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('public', 'images', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
