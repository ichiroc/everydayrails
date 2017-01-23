# coding: utf-8
FactoryGirl.define do
  factory :phone do
    association :contact
    phone '123-123-1234'
    phone_type 'home'

    # MEMO: ファクトリはネストできる
    factory :home_phone do
      phone_type 'home'
    end

    factory :work_phone do
      phone_type 'work'
    end

    factory :mobile_phone do
      phone_type 'mobile'
    end

  end
end
