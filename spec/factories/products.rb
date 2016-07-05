FactoryGirl.define do
  factory :product do
    initiative "MyString"
    local_code 1
    description "MyString"
    barcode 1
    default_price "9.99"
    promo_price "9.99"
    quantity 1
    status 1
  end
end
