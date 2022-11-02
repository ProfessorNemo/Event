# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "owner#{n}@example.com" }
    password { 'Password23516!' }
    password_confirmation { 'Password23516!' }
  end
end
