FactoryBot.define do
  factory :course do
    title { Faker::Educator.course_name }
    description { Faker::Quote.matz }
  end
end
