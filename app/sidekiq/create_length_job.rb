class CreateLengthJob
  include Sidekiq::Job

  def perform(member, length)
    LengthAnalytic.create!(member_id: member, comment_length: length)
  end
end
