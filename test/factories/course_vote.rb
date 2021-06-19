FactoryBot.define do
  factory :course_vote, class: 'Vote' do
    association :voteable, factory: :course
    association :user
  end
end
