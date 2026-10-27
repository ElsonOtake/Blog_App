# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Member.any?
  members = [
    { name: 'Elson', bio: 'Student from Brazil', email: 'elson@blog.com' },
    { name: 'Worash', bio: 'Student from Ethiopia', email: 'worash@blog.com' },
    { name: 'Jesus', bio: 'Student from Mexico', email: 'jesus@blog.com' },
    { name: 'Darik', bio: 'Student from Ethiopia', email: 'darik@blog.com' },
    { name: 'Gabriel', bio: 'Student from Brazil', email: 'gabriel@blog.com' },
    { name: 'David', bio: 'Student from Ecuador', email: 'david@blog.com' },
    { name: 'Brenda', bio: 'Student from Rwanda', email: 'brenda@blog.com' },
    { name: 'Addisu', bio: 'Student from Ethiopia', email: 'addisu@blog.com' },
    { name: 'Tinashe', bio: 'Student from Zimbabwe', email: 'tinashe@blog.com' },
    { name: 'Gabriel', bio: 'Student from Brazil', email: 'santo@blog.com' },
    { name: 'Arturo', bio: 'Student from Ecuador', email: 'arturo@blog.com' }
  ]

  members.each do |attributes|
    member = Member.new(attributes.merge(password: 'foobar', password_confirmation: 'foobar'))
    email_name = member.email.split('@').first
    avatar_path = Rails.root.join('app/assets/images').glob("#{email_name}.{jpg,jpeg,png}").first
    raise "Avatar image not found for #{member.email}" unless avatar_path

    File.open(avatar_path, 'rb') do |file|
      member.avatar.attach(io: file, filename: avatar_path.basename.to_s)
      member.save!
    end
  end
end

unless Post.any?
  members = Member.all
  members.each do |member|
    Faker::Number.between(from: 1, to: 10).times do
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
    Faker::Number.between(from: 0, to: 5).times do
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

unless BrowserAnalytic.any?
  members = Member.pluck(:id)
  devices = %w[mobile tablet console bot desktop other]
  platforms = %w[android ios mac ubuntu windows]
  actions = %w[create update delete]
  ((Date.today - 9.day)..Date.today).each do |created|
    rand(0..10).times do
      visitor = Visitor.where(
        user_agent: "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0",
        member_id: members[rand(members.size)],
        created_at: created).first_or_create.id
      device = devices[rand(devices.size)]
      platform = platforms[rand(platforms.size)]
      rand(0..5).times do
        member = members[rand(members.size)]
        UniqueAnalytic.where(
          visitor_id: visitor,
          member_id: member,
          created_at: created).first_or_create
        BrowserAnalytic.where(
          visitor_id: visitor,
          member_id: member,
          device: device,
          platform: platform,
          created_at: created).first_or_create
        actions.sample(rand(0..3)).each do |action|
          count = rand(1..5)
          CounterAnalytic.create!(
            action: action,
            count: count,
            member_id: member,
            visitor_id: visitor,
            created_at: created)
          if action == "create"
            count.times do
              LengthAnalytic.create!(
                comment_length: rand(5..50),
                member_id: member,
                created_at: created)
            end
          end
        end
      end
    end
  end
end
