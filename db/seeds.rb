# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless Member.any?
  Member.create!(name: "Elson", bio: "Student from Brazil", email: "elson@blog.com", password: "password", password_confirmation: "password")
  Member.create!(name: "Worash", bio: "Student from Ethiopia", email: "worash@blog.com", password: "password", password_confirmation: "password")
  Member.create!(name: "Jesus", bio: "Student from Mexico", email: "jesus@blog.com", password: "password", password_confirmation: "password")
  Member.create!(name: "Darik", bio: "Student from Ethiopia", email: "darik@blog.com", password: "password", password_confirmation: "password")
  Member.create!(name: "Gabriel", bio: "Student from Brazil", email: "gabriel@blog.com", password: "password", password_confirmation: "password")
  Member.create!(name: "David", bio: "Student from Ecuador", email: "david@blog.com", password: "password", password_confirmation: "password")
end

unless Post.any?
  members_id = Member.pluck(:id)
  members_id.each do |id|
    member = Member.find(id)
    Faker::Number.between(from: 1, to: 25).times do
      member.posts.create!(
        title: Faker::Lorem.sentence,
        text: Faker::Lorem.unique.paragraph(sentence_count: 2)
      )
    end
  end
end

unless Comment.any?
  post_id = Post.pluck(:id)
  post_id.each do |id|
    post = Post.find(id)
    Faker::Number.between(from: 0, to: 10).times do
      post.comments.create!(
        text: Faker::Lorem.paragraph(sentence_count: 2),
        author_id: members_id[Faker::Number.between(from: 1, to: members_id.size) - 1]
      )
    end
  end
end
