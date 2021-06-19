FactoryBot.define do
  factory :user_vote, class: 'Vote' do
    association :voteable, factory: :user
    association :user
  end
end
