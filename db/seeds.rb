require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Registration.destroy_all
User.destroy_all
Course.destroy_all
Vote.destroy_all

main_user = User.create(email: 'user@academy.com', password: 'password')
2.times do
  description = Faker::Lorem.sentence(word_count: 100, supplemental: true, random_words_to_add: 4)
  course = Course.create(title: Faker::Educator.unique.subject, description: description)
  main_user.courses << course
end

2.times do
  user = User.create(email: Faker::Internet.unique.email, password: Faker::Internet.password)
  2.times do
    description = Faker::Lorem.sentence(word_count: 100, supplemental: true, random_words_to_add: 4)
    course = Course.create(title: Faker::Educator.unique.subject, description: description)
    user.courses << course
    Vote.create(voteable: course, user_id: user.id)
    Vote.create(voteable: user, user_id: user.id)
  end
end
