class AddUniqueJob < ApplicationJob
  queue_as :default

  def perform(member, visitor)
    UniqueAnalytic.where(member_id: member,
                         visitor_id: visitor).first_or_create!
  end
end
