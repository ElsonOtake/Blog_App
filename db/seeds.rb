# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Member.any?
  Member.create!(name: 'Elson', bio: 'Student from Brazil', email: 'elson@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Worash', bio: 'Student from Ethiopia', email: 'worash@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Jesus', bio: 'Student from Mexico', email: 'jesus@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Darik', bio: 'Student from Ethiopia', email: 'darik@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Gabriel', bio: 'Student from Brazil', email: 'gabriel@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'David', bio: 'Student from Ecuador', email: 'david@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Brenda', bio: 'Student from Rwanda', email: 'brenda@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Addisu', bio: 'Student from Ethiopia', email: 'addisu@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Tinashe', bio: 'Student from Zimbabwe', email: 'tinashe@blog.com', password: 'foobar', password_confirmation: 'foobar')
  Member.create!(name: 'Gabriel', bio: 'Student from Brazil', email: 'santo@blog.com', password: 'foobar', password_confirmation: 'foobar')  
  Member.create!(name: 'Arturo', bio: 'Student from Ecuador', email: 'arturo@blog.com', password: 'foobar', password_confirmation: 'foobar')
end

unless Post.any?
  members = Member.all
  members.each do |member|
    Faker::Number.between(from: 1, to: 50).times do
      member.posts.create!(
        title: Faker::Quote.famous_last_words,
        text: Faker::Quote.jack_handey
      )
    end
  end
end

unless Comment.any?
  member_ids = Member.pluck(:id)
  posts = Post.all
  posts.each do |post|
    Faker::Number.between(from: 0, to: 20).times do
      post.comments.create!(
        text: Faker::Quote.most_interesting_man_in_the_world,
        author_id: member_ids[Faker::Number.between(from: 1, to: member_ids.size) - 1]
      )
    end
  end
end

unless Like.any?
  member_ids = Member.pluck(:id)
  posts = Post.all
  posts.each do |post|
    aux = []
    Faker::Number.between(from: 0, to: member_ids.size).times do
      member = member_ids[Faker::Number.between(from: 1, to: member_ids.size) - 1]
      aux << member unless aux.include? member
    end
    aux.each do |id|
      post.likes.create!(author_id: id)
    end
  end
end
