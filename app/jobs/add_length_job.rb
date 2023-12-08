class AddLengthJob < ApplicationJob
  queue_as :default

  def perform(member, length)
    LengthAnalytic.create!(member_id: member, comment_length: length)
  end
end
