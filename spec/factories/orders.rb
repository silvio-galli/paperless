FactoryGirl.define do
  factory :order do
    customer nil
    notes "MyText"
    total_price "9.99"
  end
end
