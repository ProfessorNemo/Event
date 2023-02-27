# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { FFaker::Lorem.sentence(5) }
    address { FFaker::AddressAU.full_address }
    description { FFaker::Lorem.sentence(15) }
    datetime { 30.days.from_now }
    pincode { rand(100..999) }
    notifications { [true, false].sample }
    association :user, :id

    trait :with_avatar do
      after :create do |event|
        file_name = 'avatar.jpeg'
        file_path = Rails.root.join('spec', 'support', file_name)
        event.snapshot.attach(io: File.open(file_path),
                              filename: file_name,
                              content_type: 'avatar/jpeg')
      end
    end
  end
end
