# frozen_string_literal: true

FactoryBot.define do
  factory :blog_post do
    company
    body { 'Zażółć gęślą jaźń' }
  end
end
