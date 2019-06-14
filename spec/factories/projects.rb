# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'MyString' }
    started_at { '2018-12-28 03:06:08' }
    stopped_at { '2018-12-28 03:06:08' }
    dev_category { nil }
  end
end
