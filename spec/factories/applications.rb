FactoryBot.define do
  factory :application, class: 'doorkeeper/application' do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri { 'https://app.com/callback' }
  end
end