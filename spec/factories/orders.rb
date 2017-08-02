FactoryGirl.define do
  factory :order do
    cart nil
    payment_status "MyString"
    paid_at "2017-08-02 09:27:44"
    currency "MyString"
    unique_token "MyString"
    payment_description "MyString"
    total ""
    total ""
  end
end
